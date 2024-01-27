provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAQA55PZDYWTWASB65"
  secret_key = "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"
}

resource "aws_instance" "myfirst" {
  ami             = "ami-0ba62214afa52bec7"
  instance_type   = "t2.micro"
  key_name        = "DevOps"
  security_groups = ["default"]
}

