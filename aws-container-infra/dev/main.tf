module "ecr" {

  source        = "../modules/ecr"
  ecr_repo_name = "terraform-ecr"
}