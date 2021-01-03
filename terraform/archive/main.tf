# Reference: https://www.terraform.io/docs/configuration/providers.html

# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.
provider "aws" {
  profile = "personal-admin"
  region  = "ap-southeast-1"
}

# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
  alias   = "secondary"
  profile = "personal-admin"
  region  = "ap-southeast-2"
}
