variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
  default = "jenkins_tesing.pub"
}

variable "credentials_file" {
  default = "~/.aws/credentials"
}

variable "profile" {
  default = "default"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-1"
}

variable "aws_ami" {
  default = ""
}

variable "aws_tags" {
  description = "AWS tags"
  default = {
    Name = "jenkings-testing"
    User = "nroberts"
  }
}
