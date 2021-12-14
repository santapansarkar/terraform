resource "aws_ecr_repository" "terraform" {
  name                 = "${var.ecr_repo_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "console" {

  name = "console-ecr"
  
}