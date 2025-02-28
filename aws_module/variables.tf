variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for resources"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "flask_ami_id" {
  description = "AMI ID for the Flask app EC2 instance"
  type        = string
}

variable "flask_instance_type" {
  description = "Instance type for the Flask app EC2 instance"
  type        = string
}

variable "iam_role" {
  description = "IAM role to be associated with EC2 instances"
  type        = string
}
