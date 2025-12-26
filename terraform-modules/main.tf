module "dev-infra" {
    source = "./infra-app"
    env = "dev"
    bucket_name = "infra-app-bucket-pmshrik-01"
    instance_count = 1
    instance_type = "t3.micro"
    ec2_ami_id = "ami-068c0051b15cdb816"
    hash_key = "studentID"

  
}

module "prod-infra" {
    source = "./infra-app"
    env = "prod"
    bucket_name = "infra-app-bucket-pmshrik-01"
    instance_count = 1
    instance_type = "t3.medium"
    ec2_ami_id = "ami-068c0051b15cdb816"
    hash_key = "studentID"
  
}

module "stg-infra" {
    source = "./infra-app"
    env = "stg"
    bucket_name = "infra-app-bucket-pmshrik-01"
    instance_count = 1
    instance_type = "t3.small"
    ec2_ami_id = "ami-068c0051b15cdb816"
    hash_key = "studentID"

  
}