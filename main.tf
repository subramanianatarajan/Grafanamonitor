provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "GrafanaInstance" {
  ami           = "ami-0e83be366243f524a"
  instance_type = "t2.micro"

   tags = {
     Name        = "GrafanaServer"
     Description = "Used for monitoring Instance"
   }
   user_data = <<-EOF
     #!/bin/bash
     sudo apt update
     EOF

   key_name = aws_key_pair.terraformfirst.id
   vpc_security_group_ids = [aws_security_group.ssh-access.id]
 }
 resource "aws_key_pair" "newkey2" {
   key_name   = "newkey2"
   public_key = file("./newykey.pem")
 }
 resource "aws_security_group" "ssh-access" {
   name        = "ssh-access"
   description = "Allow SSH access from the Internet"

   ingress {
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
}
output "public_address" {
  value = aws_instance.GrafanaInstance.public_ip
}



