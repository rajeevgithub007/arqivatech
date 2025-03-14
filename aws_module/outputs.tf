# output "jenkins_server_ip" {
#   description = "The public IP of the Jenkins server"
#   value       = aws_cloudformation_stack.app_stack.outputs["JenkinsServerPublicIP"]
# }

# Outputs
# output "flask_app_server_ip" {
#   description = "The public IP of the Flask application server"
#   value       = aws_instance.flask_app.public_ip
# }

# # Output the Jenkins Security Group ID from the first CloudFormation stack
# output "jenkins_security_group_id" {
#   description = "The Security Group ID for Jenkins"
#   value       = data.aws_cloudformation_stack.jenkins_sg_stack.outputs["JenkinsSecurityGroupId"]
# }

# # Output the Jenkins Server public IP from the second CloudFormation stack
# output "jenkins_server_ip" {
#   description = "The public IP of the Jenkins server"
#   value       = data.aws_cloudformation_stack.jenkins_server_stack.outputs["JenkinsServerPublicIP"]
# }
