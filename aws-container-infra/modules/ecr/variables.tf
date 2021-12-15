variable "ecr_repo_name" {
  type = string
  default = "terraform-ecr"
}

variable "repositories" {
  type = set(string)
  description = "list of repositories"
  default = [
    "init-containers",
    "batch-containers",
    "web-containers",
    "db-containers"
     ]
}