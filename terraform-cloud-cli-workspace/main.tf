module "vpc" {

  source              = "./modules/vpc"
  vpc_cidr_block      = "10.0.0.0/16"
  vpc_env             = "dev"
  vpc_name            = "terraform"
  public_subnet_name  = "terraform-public-subnet"
  private_subnet_name = "terraform-private-subnet"
}