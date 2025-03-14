variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default = "eu-west-2"
}

variable "vpc_id" {
  description = "VPC ID for resources"
  type        = string
  default = "vpc-0b74b938c4056ab9b"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default = "new-key-pair"

}

variable "flask_ami_id" {
  description = "AMI ID for the Flask app EC2 instance"
  type        = string
  default     = "ami-003c3655bc8e97ae1" 
}

variable "flask_instance_type" {
  description = "Instance type for the Flask app EC2 instance"
  type        = string
  default     = "t2.micro"
}
