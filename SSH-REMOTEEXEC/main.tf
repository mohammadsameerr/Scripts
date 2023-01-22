resource "aws_instance" "sam-ec2" {

    ami = "ami-074dc0a6f6c764218"
    instance_type = "t2.micro"
    key_name = "new-keypair"

    connection {

      type ="ssh"
      user = "ec2-user"
      private_key = file("./my-keypair.pem")
      host = self.public_ip
    }
    
  provisioner "remote-exec" {

    inline = [
      "sudo yum install curl"
      
    ]
    
  }
  
}

