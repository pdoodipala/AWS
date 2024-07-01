# Environment 
ENV = "dev"
# AWS Network
VPC_CICR = "10.0.0.0/16"
public_subnet_1 = "10.0.101.0/24"
public_subnet_2 = "10.0.102.0/24"
private_subnet_1 = "10.0.1.0/24"
private_subnet_2 = "10.0.2.0/24"
# EC2 Instance
key_pair_name = "terraformtest"
instance_ami = "ami-04b70fa74e45c3917"
instanceType = "t2.micro"
root_device_size = "20"
root_device_type = "gp2"