
/*
Only available from Terraform 1.11 and later, hence commmneted to run with current version 
terraform {
  cloud {
    organization = "own-terraform"

    workspaces {
      name = "terraform-cloud-cli-workspace"
    }
  }
}
*/

# Using a single workspace:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "own-terraform"

    workspaces {
      name = "terraform-cloud-cli-workspace"
    }
  }
}

/*
# Using multiple workspaces:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "company"

    workspaces {
      prefix = "my-app-"
    }
  }
}
*/