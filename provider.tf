# Configure the AWS Provider

terraform { 
  cloud { 
    organization = "gubi" 
    workspaces { 
      name = "gitaction" 
    } 
  } 
}

providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
