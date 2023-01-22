resource "aws_key_pair" "Key1" {
  key_name   = "Skey"
  public_key = file("~/.ssh/terraform.pub")
}

resource "aws_instance" "samEC2" {
  key_name      = aws_key_pair.Key1.key_name
  ami           = var.ami-id
  instance_type = var.instance-type

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/terraform")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx"
    ]
  }
}
