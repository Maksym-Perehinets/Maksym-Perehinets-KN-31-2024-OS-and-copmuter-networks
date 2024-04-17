#get ima for desierd image
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "key-for-test"
  public_key = file("keys/key.pub")
}


module "vpc-subnet" {
  source                  = "./modules/vpc-subnet"
  desired_cdir_for_public = "10.10.10.0/24"
  desired_cdir            = "10.10.11.0/24"
}

module "route-tables" {
  source            = "./modules/route-tables"
  private_subnet_id = module.vpc-subnet.private_subnet_id
  public_subnet_id  = module.vpc-subnet.public_subnet_id
  gateway_id        = module.vpc-subnet.gateway_id
  vpc_id            = module.vpc-subnet.vpc_id
}

module "ec2" {
  source                     = "./modules/ec2"
  allow_local_security_group = [module.vpc-subnet.allow_local_id]
  allow_ssh_security_group   = [module.vpc-subnet.allow_ssh_id]
  private_subnet_id          = module.vpc-subnet.private_subnet_id
  public_subnet_id           = module.vpc-subnet.public_subnet_id
  key_pair                   = resource.aws_key_pair.ssh-key.key_name
  ami                        = data.aws_ami.ubuntu.id
  arn                        = [module.route-tables.arn]

  depends_on = [ module.vpc-subnet ]
}
