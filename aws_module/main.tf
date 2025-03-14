provider "aws" {
  region = var.region
}

resource "aws_security_group" "flask_app_sg" {
  name        = "flask-app-sg"
  description = "Enable HTTP access to Flask app"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "flask_app" {
  ami                    = var.flask_ami_id
  instance_type          = var.flask_instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.flask_app_sg.name]
  iam_instance_profile   = var.instance_profile
  tags = {
    Name = "FlaskAppServer"
  }

  associate_public_ip_address = true
}

output "flask_app_server_ip" {
  description = "The public IP of the Flask application server"
  value       = aws_instance.flask_app.public_ip
}

# Get the Jenkins Security Group output from the first CloudFormation stack
data "aws_cloudformation_stack" "jenkins_sg_stack" {
  name = "terraform-resources-arqi"  # Replace with your Jenkins Security Group stack name
}

# Get the Jenkins Server output from the second CloudFormation stack
data "aws_cloudformation_stack" "jenkins_server_stack" {
  name = "terraform-resources-arqivas"  # Replace with your Jenkins Server stack name
}

