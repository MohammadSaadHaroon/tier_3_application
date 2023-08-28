resource "aws_instance" "webapp" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_type
  key_name                    = var.ec2_keypair
  subnet_id                   = aws_subnet.tier_public[count.index].id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count                       = 2

  tags = {
    Name    = "webserver"
    Service = "web-app"
    project = "3-tier-application"
  }
  provisioner "file" {
    source      = "./web_tier_key_pair.pem"
    destination = "/home/ec2-user/web_tier_key_pair.pem"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./web_tier_key_pair.pem")
    }
  }

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
              EOF
}

resource "aws_instance" "database" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_type
  key_name               = var.ec2_keypair
  subnet_id              = aws_subnet.tier_private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name    = "dbserver"
    Service = "Database"
    project = "3-tier-application"
  }

  user_data = <<-EOF
                #!/bin/bash
              yum update -y
              yum install -y mysql-server
              systemctl start mysqld
              systemctl enable mysqld
              EOF

}