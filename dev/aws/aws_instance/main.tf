
# get images from image repository
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]  # Amazon-owned AMIs

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-*"]  # Amazon Linux 2023
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ec2_instance" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    tags = {
        Name = var.name 
    }
    ebs_block_device {
        device_name = "/dev/sda1"
        volume_size = 10
        volume_type = "gp2" # this means general purpose SSD
        delete_on_termination = true
    }  
}

# t2.micro
# 10 dynamoDB capacity units
# 10 GB of volume
# name = cloudacademylabs
# s3 bucket for state 