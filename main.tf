# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file  = "${var.credentials_file}"
  profile                  = "${var.profile}"
}

resource "aws_security_group" "jenkins-testing" {
  name        = "jenkins-testing"
  description = "jenkins-testing"
  tags = "${var.aws_tags}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "jenkins-build-test" {
  connection {
    user = "ubuntu"
  }

  instance_type = "t2.micro"

  ami = "${var.aws_ami}"

  key_name = "${aws_key_pair.auth.id}"

  vpc_security_group_ids = ["${aws_security_group.jenkins-testing.id}"]

  tags = "${var.aws_tags}"

  provisioner "file" {
        source = "tests"
        destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install ruby-serverspec",
      "cd /tmp/tests && rake"
    ]
  }
}
