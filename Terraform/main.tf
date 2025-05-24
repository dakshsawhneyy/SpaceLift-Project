resource "aws_key_pair" "my_key" {
  key_name   = "tf-key"
  public_key = file(var.public_key)
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}

locals{
    instances = {
        instance1 = {
            ami = var.ami_id
            instance_type = "t2.micro"
            volume_size = var.volume_size
        }
        instance2 = {
            ami = var.ami_id
            instance_type = "t2.medium"
            volume_size = var.volume_size
        }
        instance3 = {
            ami = var.ami_id
            instance_type = "t2.micro"
            volume_size = var.volume_size
        }
    }
}

resource "aws_instance" "web" {
    for_each = local.instances
    ami           = each.value.ami
    instance_type = each.value.instance_type
    root_block_device {
        volume_size = each.value.volume_size
    }
    key_name      = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.allow_ssh.name]
    tags = {
        Name = "web-${each.key}"
    }
}
