# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file  = "/home/nroberts/.aws/credentials"
  profile                  = "thislife-dev"

}

resource "aws_security_group" "jenkins-tester" {
  name        = "jenkins-tester"
  description = "jenkins-tester"
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

  ami = "${lookup(var.aws_amis, var.aws_region)}"

  key_name = "${aws_key_pair.auth.id}"

  vpc_security_group_ids = ["${aws_security_group.jenkins-tester.id}"]

  tags = "${var.aws_tags}"

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
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
