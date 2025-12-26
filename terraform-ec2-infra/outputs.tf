output "aws_instance_public_ip" {
    value = [
        for instance in aws_instance.demo_instance : instance.public_ip
    ]
  
}
output "aws_instance_private_ip" {
    value = [
        for instance in aws_instance.demo_instance : instance.private_ip
    ]
  
}
