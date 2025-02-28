output "flask_app_server_ip" {
  description = "The public IP of the Flask application server"
  value       = module.aws_resources.flask_app_server_ip
}

output "jenkins_server_ip" {
  description = "The public IP of the Jenkins server"
  value       = module.aws_resources.jenkins_server_ip
}
