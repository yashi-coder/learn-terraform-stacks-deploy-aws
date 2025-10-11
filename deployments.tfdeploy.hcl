# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

publish_output "deployment_instance_ids" {
  description = "The instance Stack's Instance's ID."
  value       = deployment.development.intance_ids
}

deployment "development" {
  inputs = {
    regions        = ["us-east-2"]
    role_arn       = "arn:aws:iam::600627341735:role/AWS-cred-terraform-auth-test"
    identity_token = identity_token.aws.jwt
    default_tags = {
      Stack       = "learn-stacks-deploy-aws",
      Environment = "dev"
    }
  }
  #destroy = true
}

deployment "production" {
  inputs = {
    regions        = ["us-west-1"]
    role_arn       = "arn:aws:iam::600627341735:role/AWS-cred-terraform-auth-test"
    identity_token = identity_token.aws.jwt
    default_tags = {
      Stack       = "learn-stacks-deploy-aws",
      Environment = "prod"
    }
  }
  destroy = true
}
