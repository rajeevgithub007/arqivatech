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
  iam_instance_profile   = var.iam_role
  tags = {
    Name = "FlaskAppServer"
  }

  associate_public_ip_address = true
}

output "flask_app_server_ip" {
  description = "The public IP of the Flask application server"
  value       = aws_instance.flask_app.public_ip
}

output "jenkins_server_ip" {
  description = "The public IP of the Jenkins server"
  value       = aws_cloudformation_stack.app_stack.outputs["JenkinsServerPublicIP"]
}
