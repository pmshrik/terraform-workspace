#key-pair for ec2
resource "aws_key_pair" "demo_key_pair" {
    key_name = "${var.env}-demo_key"
    public_key = file("demo_key.pub")
}
#vpc for ec2
resource "aws_default_vpc" "default" {
    tags = {
      Name = "Default-vpc"
    }
}
#security group for ec2
resource "aws_security_group" "demo_security" {
    name = "${var.env}-demo_security"
    description = "demo security group for ec2"
    vpc_id = aws_default_vpc.default.id
    tags = {
      Name = "${var.env}-demo_security"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "ssh open port"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "http port"
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}
#ec2 instance
resource "aws_instance" "demo_instance" {
    for_each = tomap({
        t3_micro_instance = "t3.micro"
        t3_medium_instance = "t3.medium"

    })
    depends_on = [ aws_security_group.demo_security, aws_key_pair.demo_key_pair ]


    key_name = aws_key_pair.demo_key_pair.key_name
    vpc_security_group_ids = [aws_security_group.demo_security.id]
    instance_type = each.value
    ami = var.aws_ami_id
    user_data = file("install_nginx.sh")

    root_block_device {
      volume_size = var.env == "prod"? 20 : var.ec2_default_root_storage
      volume_type = "gp3"
    }
    tags = {
      Name = each.key
      Environment = var.env
    }
}

