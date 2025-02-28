variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "flask_ami_id" {
  description = "AMI ID for the Flask EC2 instance"
  type        = string
}

variable "flask_instance_type" {
  description = "EC2 instance type for Flask app"
  type        = string
}
