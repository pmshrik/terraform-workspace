resource "aws_key_pair" "remote_key" {
    key_name = "${var.env}-infra_key"
    public_key = file("demo_key.pub")
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "remote_security" {
    name = "${var.env}-infra_security"
    description = "This is remote security group"
    vpc_id = aws_default_vpc.default.id

    tags = {
      Name = "${var.env}-infra_security"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "shh port open"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "http port open"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "remote_instance" {
    key_name = aws_key_pair.remote_key.key_name
    count = var.instance_count
    instance_type = var.instance_type
    ami = var.ec2_ami_id
    vpc_security_group_ids = [aws_security_group.remote_security.id]
    depends_on = [ aws_key_pair.remote_key, aws_security_group.remote_security ]

    root_block_device {
      volume_size = var.env == "prod" ? 20 : 10
      volume_type = "gp3"
    }

    tags = {
      Name = "${var.env}-infra_ec2"
      Environment = var.env
    }
  
}