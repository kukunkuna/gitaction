# Configure the AWS Provider
provider "aws" {
  skip_metadata_api_check = true
  region                  = "us-east-1"
}

terraform { 
  cloud { 
    organization = "gubi" 
    workspaces { 
      name = "gitaction" 
    } 
  } 
}
