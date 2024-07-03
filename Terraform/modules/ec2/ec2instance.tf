# ec2-security group
resource "aws_security_group" "allow_ssh" {
  name        = local.ssh
  description = "Allow external SSH connectivity to EC2 instances"
  vpc_id      = aws_vpc.vpc-devopstooling.id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = local.ssh
  }
}

# iam role and policy
resource "aws_iam_role" "ec2-role" {
  name = local.ec2role

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            }
        }
    ]
}
POLICY  
}

resource "aws_iam_role_policy_attachment" "amazon-ec2-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.ec2-role.name
}

resource "aws_iam_instance_profile" "ec2-profile" {
  name = local.ec2profile
  role = aws_iam_role.ec2-role.name
}

# ssh keypair
resource "tls_private_key" "ec2key" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "private_key" {
  filename        = "ec2.pem"
  content         = tls_private_key.ec2key.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "ec2key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2key.public_key_openssh
}

# resource block for eip #
resource "aws_eip" "ec2eip" {
  vpc      = true
}

# resource block for ec2 and eip association #
resource "aws_eip_association" "ec2eip_assoc" {
  instance_id   = aws_instance.ec2-instance.id
  allocation_id = aws_eip.ec2eip.id
}

resource "aws_instance" "ec2-instance" {
    ami = var.instance_ami
    subnet_id = aws_subnet.public-subnet-1.id
    instance_type = var.instanceType
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    key_name = aws_key_pair.ec2key_pair.key_name
    iam_instance_profile = aws_iam_instance_profile.ec2-profile.name

    root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = var.root_device_size
    volume_type           = var.root_device_type
  }
  
  tags = {
    "Name" = local.ec2
  }
}