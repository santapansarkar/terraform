resource "aws_ecr_repository" "terraform" {
  for_each             = "${var.repositories}"
  name                 = "${var.ecr_repo_name}/${each.value}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

