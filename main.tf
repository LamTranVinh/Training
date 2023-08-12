output "instance_public_ip" {
  value = MyEC2Instance.public_ip
}

variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret key"
}
provider "aws" {
  region = "ap-northeast-2"  # Replace with your desired region
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0c9c942bd7bf113a2"  # Replace with your desired AMI ID
  instance_type = "t2.micro"               # Replace with your desired instance type

  vpc_security_group_ids = ["sg-0afe369c8a18dcd91"]  # Replace with your security group ID

  subnet_id = "subnet-0397861f148d6e68b"  # Replace with your subnet ID

  key_name = "ssh-key-pem-ansible-playbook"  # Replace with your key pair name

  tags = {
    Name = "MyEC2Instance"
  }
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}
