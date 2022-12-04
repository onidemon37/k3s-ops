terraform {

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.29.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.1"
    }
  }
}

data "sops_file" "cloudflare_secrets" {
  source_file = "secret.sops.yaml"
}

provider "cloudflare" {
  email   = data.sops_file.cloudflare_secrets.data["cloudflare_email"]
  api_key = data.sops_file.cloudflare_secrets.data["cloudflare_apikey"]
}

# ninhu.xyz zone
data "cloudflare_zones" "domain" {
  filter {
    name = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  }
}

# exposure37 zone
#data "cloudflare_zones" "domain_exp" {
#  filter {
#    name = data.sops_file.cloudflare_secrets.data["cloudflare_domain_exp"]
#  }
#}

# andorigna zone
#data "cloudflare_zones" "domain_and" {
#  filter {
#    name = data.sops_file.cloudflare_secrets.data["cloudflare_domain_and"]
#  }
#}
