variable "aws_instance_type" {
    type = string
    default = "t3.micro"
}
variable "aws_ami_id" {
    type = string
    default = "ami-0ecb62995f68bb549"
}
variable "ec2_default_root_storage" {
    type = number
    default = 8 
}
variable "env" {
    default = "prod"
    type = string
  
}