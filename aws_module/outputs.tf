output "flask_app_server_ip" {
  description = "The public IP of the Flask application server"
  value       = aws_instance.flask_app.public_ip
}

output "jenkins_server_ip" {
  description = "The public IP of the Jenkins server"
  value       = aws_cloudformation_stack.app_stack.outputs["JenkinsServerPublicIP"]
}
