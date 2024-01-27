provider "aws" {
  region     = "us-east-2"
  access_key = "AKIASPRZAE6S"
  secret_key = "4TQh/WtwqrhYcIZUQfVYkr1jBo7ee"
}

resource "aws_instance" "myfirst" {
  ami             = "ami-0ba62214afa52bec7"
  instance_type   = "t2.micro"
  key_name        = "DevOps"
  security_groups = ["${aws_security_group.allow_all.name}"]

provisioner "remote-exec" {
    inline                  = [
	"sudo apt install httpd -y",
	"sudo service httpd start"
    ]

    connection {
        type                = "ssh"
        user                = "ec2-user"
        private_key         = file("./DevOps.pem")
        host                = aws_instance.myfirst.public_ip
    }
  }
}
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-0c196d2f41c8aef79"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "PublicIP" {
      value="${aws_instance.myfirst.public_ip}"
}
output "PrivateIP" {
      value="${aws_instance.myfirst.private_ip}"
}

