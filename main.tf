provider "aws" {
  region = var.region
}

resource "aws_cloudformation_stack" "app_stack" {
  name = "app-stack"
  template_body = file("${path.module}/cloudformation/iam_roles_resources.yaml")
}

module "aws_resources" {
  source = "../aws_module"
  region = var.region
  vpc_id = var.vpc_id
  key_name = var.key_name
  flask_ami_id = var.flask_ami_id
  flask_instance_type = var.flask_instance_type
  iam_role = aws_iam_role.iam_role.name
}
