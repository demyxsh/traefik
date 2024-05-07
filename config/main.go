package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"

	yaml "gopkg.in/yaml.v2"
)

var traefikData = `
entryPoints:
  http:
    address: :80
  https:
    address: :443
    http3: {}
    forwardedHeaders:
      trustedIPs:
      - ` + traefikCloudflareIPs() + `

certificatesResolvers:
  demyx:
    acme:
      email: ` + os.Getenv("DEMYX_ACME_EMAIL") + `
      storage: ` + os.Getenv("DEMYX") + `/acme.json
      httpChallenge:
        entryPoint: http
  demyx-cf:
    acme:
      email: ` + os.Getenv("DEMYX_ACME_EMAIL") + `
      storage: ` + os.Getenv("DEMYX") + `/acme.json
      dnsChallenge:
        provider: cloudflare
        delayBeforeCheck: 0
        resolvers:
          - 1.1.1.1

tls:
  options:
    default:
      minVersion: VersionTLS12
      sniStrict: true
      cipherSuites:
        - TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305
        - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305
        - TLS_AES_256_GCM_SHA384
        - TLS_CHACHA20_POLY1305_SHA256
        - TLS_FALLBACK_SCSV
      curvePreferences:
        - secp521r1
        - secp384r1
    modern:
      minVersion: VersionTLS13

providers:
  docker:
    endpoint: ` + os.Getenv("DEMYX_ENDPOINT") + `
    exposedByDefault: false

api:
  dashboard: true
  insecure: true

log:
  level: INFO
  filePath: ` + os.Getenv("DEMYX_LOG") + `/traefik.error.log

accessLog:
  filePath: ` + os.Getenv("DEMYX_LOG") + `/traefik.access.log
`

// TraefikYamlStruct ...
type TraefikYamlStruct struct {
	EntryPoints struct {
		HTTP struct {
			Address          string `yaml:"address"`
			ForwardedHeaders struct {
				TrustedIPs []string `yaml:"trustedIPs"`
			} `yaml:"forwardedHeaders"`
		} `yaml:"http"`
		HTTPS struct {
			Address          string   `yaml:"address"`
			HTTP3            struct{} `yaml:"http3"`
			ForwardedHeaders struct {
				TrustedIPs []string `yaml:"trustedIPs"`
			} `yaml:"forwardedHeaders"`
		} `yaml:"https"`
	} `yaml:"entryPoints"`
	CertificatesResolvers struct {
		Demyx struct {
			Acme struct {
				Email         string `yaml:"email"`
				Storage       string `yaml:"storage"`
				HTTPChallenge struct {
					EntryPoint string `yaml:"entryPoint"`
				} `yaml:"httpChallenge"`
			} `yaml:"acme"`
		} `yaml:"demyx"`
		DemyxCf struct {
			Acme struct {
				Email        string `yaml:"email"`
				Storage      string `yaml:"storage"`
				DNSChallenge struct {
					Provider         string   `yaml:"provider"`
					DelayBeforeCheck int      `yaml:"delayBeforeCheck"`
					Resolvers        []string `yaml:"resolvers"`
				} `yaml:"dnsChallenge"`
			} `yaml:"acme"`
		} `yaml:"demyx-cf"`
	} `yaml:"certificatesResolvers"`
	TLS struct {
		Options struct {
			Default struct {
				MinVersion       string   `yaml:"minVersion"`
				SniStrict        string   `yaml:"sniStrict"`
				CipherSuites     []string `yaml:"cipherSuites"`
				CurvePreferences []string `yaml:"curvePreferences"`
			} `yaml:"default"`
			Modern struct {
				MinVersion string `yaml:"minVersion"`
			} `yaml:"modern"`
		} `yaml:"options"`
	} `yaml:"tls"`
	Providers struct {
		Docker struct {
			Endpoint         string `yaml:"endpoint"`
			ExposedByDefault bool   `yaml:"exposedByDefault"`
		} `yaml:"docker"`
	} `yaml:"providers"`
	API struct {
		Dashboard bool `yaml:"dashboard"`
		Insecure  bool `yaml:"insecure"`
	} `yaml:"api"`
	Log struct {
		Level    string `yaml:"level"`
		FilePath string `yaml:"filePath"`
	} `yaml:"log"`
	AccessLog struct {
		FilePath string `yaml:"filePath"`
	} `yaml:"accessLog"`
}

func traefikCloudflareIPs() string {
	cfIPs, err := ioutil.ReadFile(os.Getenv("DEMYX_CONFIG") + "/cf_ips")
	if err != nil {
		log.Fatal(err)
	}
	return string(cfIPs)
}

func main() {
	// Exit if DEMYX_ACME_EMAIL environment isn't found
	_, present := os.LookupEnv("DEMYX_ACME_EMAIL")
    if !present {
		fmt.Println("DEMYX_ACME_EMAIL is missing, exiting ...")
		os.Exit(1)
    }

	traefikYml := TraefikYamlStruct{}
	traefikConfig := os.Getenv("DEMYX_CONFIG") + "/traefik.yml"
	_, err := os.Stat(traefikConfig)

	// Generate Traefik's config if it doesn't exist
	if os.IsNotExist(err) {
		err = yaml.Unmarshal([]byte(traefikData), &traefikYml)
		traefikYmlMarshal, err := yaml.Marshal(&traefikYml)

		if err != nil {
			log.Fatal(err)
		}

		ioutil.WriteFile(traefikConfig, traefikYmlMarshal, 0644)
	}

	// Execute Traefik binary and stream output to stdout
	cmd := exec.Command("traefik", "--configfile="+traefikConfig)
	stdout, _ := cmd.StdoutPipe()
	if err := cmd.Start(); err != nil {
		log.Fatal(err)
	}
	reader := bufio.NewReader(stdout)
	line, err := reader.ReadString('\n')
	for err == nil {
		fmt.Println(line)
		line, err = reader.ReadString('\n')
	}
}
