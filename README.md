Flask App with Jenkins CI/CD Pipeline on AWS
--------------------------------------------
This project sets up a Flask web application on an EC2 instance in AWS, with Jenkins automating the CI/CD process for deployment. It uses Terraform for provisioning AWS infrastructure such as EC2 instances, S3 for state management, and AWS SSM Parameter Store for dynamic string retrieval.
Project Overview
The Flask app fetches a dynamic string from AWS SSM Parameter Store and displays it on a webpage. The project is fully automated using Jenkins for CI/CD, and infrastructure is provisioned with Terraform. The application and pipeline are hosted on AWS using EC2 instances and security groups for secure access.

Project Structure:
-----------------
│── aws_module/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│── cloudformation/
│   ├── cfn.yaml
│── app/
│   ├── app.py
│   ├── requirements.txt
│── Jenkinsfile
│── README.md

________________________________________
Table of Contents
1.	Project Setup
2.	Infrastructure Deployment
3.	Jenkins CI/CD Pipeline Setup
4.	Flask Application Code
5.	Jenkinsfile
6.	AWS Infrastructure
7.	Code Snippets
8.	Conclusion
________________________________________
Project Setup
Prerequisites
Before we begin, ensure that we have the following tools installed:
•	Terraform: For provisioning AWS resources. Terraform Installation Guide
•	AWS CLI: For configuring AWS credentials. AWS CLI Installation Guide
•	Python 3.x: For running the Flask app.
•	Jenkins: To set up the CI/CD pipeline.
Install Dependencies
1.	Clone the Repository:
git clone https://github.com/wer-repo/flask-app.git
cd flask-app
2.	Install Python Dependencies: Navigate to the app directory and install the required Python packages.
pip install -r requirements.txt
3.	Install Terraform: Follow the Terraform Installation Guide to install Terraform.
________________________________________
Infrastructure Deployment
Terraform Configuration
Terraform is used to provision the AWS infrastructure. The infrastructure includes EC2 instances for the Flask application and Jenkins server, security groups, and S3 for storing Terraform state.
1.	Configure Terraform Variables:
Update the variables.tf file with wer AWS credentials, region, and key pair name.
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {
  default = "us-east-1"
}
2.	Initialize Terraform: Run the following command to initialize the working directory containing Terraform configuration files.
terraform init
3.	Plan the Terraform Deployment: This command will show what actions Terraform will take.
terraform plan
4.	Apply the Terraform Configuration: Deploy the AWS infrastructure using Terraform.
terraform apply
This will provision the necessary AWS resources including the Flask app server, Jenkins server, S3 bucket for Terraform state, and security groups.
________________________________________
Jenkins CI/CD Pipeline Setup
Jenkins will automate the deployment of the Flask application. Here's how to set up the Jenkins pipeline:
1.	Install Jenkins: If not already installed, follow the Jenkins Installation Guide.
2.	Add AWS Credentials to Jenkins: Go to Jenkins > Manage Jenkins > Manage Credentials and add wer AWS access keys.
3.	Create a New Jenkins Pipeline:
o	In Jenkins, create a new item and select "Pipeline."
o	In the pipeline configuration, point to wer repository and add the following pipeline code (see Jenkinsfile below).
________________________________________
Flask Application Code
The Flask application fetches a dynamic string stored in AWS SSM Parameter Store and displays it on the web page.
app.py
python
from flask import Flask
import boto3

app = Flask(__name__)

def get_dynamic_string():
    ssm = boto3.client('ssm', region_name="us-east-1")
    response = ssm.get_parameter(Name="dynamic_string")
    return response['Parameter']['Value']

@app.route('/')
def index():
    return f"<h1>The saved string is {get_dynamic_string()}</h1>"

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)
requirements.txt
Flask==2.2.2
boto3==1.24.9
________________________________________
Jenkinsfile
The Jenkinsfile automates the CI/CD process, which includes cloning the repository, installing dependencies, and deploying the Flask application to an EC2 instance.
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
        FLASK_APP_INSTANCE_IP = '${FlaskAppServerPublicIP}'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/wer-repo/flask-app.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'pip install -r app/requirements.txt'
            }
        }
        stage('Deploy Flask App') {
            steps {
                script {
                    sh "scp -i /path/to/wer/key.pem -r app/* ec2-user@${FLASK_APP_INSTANCE_IP}:/var/www/html"
                    sh "ssh -i /path/to/wer/key.pem ec2-user@${FLASK_APP_INSTANCE_IP} 'sudo systemctl restart flask-app.service'"
                }
            }
        }
    }
}
________________________________________
AWS Infrastructure
The following AWS resources are provisioned using Terraform:
•	FlaskAppServer: EC2 instance hosting the Flask web application.
•	JenkinsServer: EC2 instance hosting Jenkins.
•	Security Groups: For securing EC2 instances and controlling inbound traffic.
•	SSM Parameter: For storing and retrieving dynamic strings.
•	S3 Bucket: For storing Terraform state.
CloudFormation Template (Flask Server Example)
Resources:
  FlaskAppServer:
    Type: AWS::EC2::Instance
    Properties:
      InstanceType: t2.micro
      ImageId: ami-0c55b159cbfafe1f0
      KeyName: my-key-pair
      SecurityGroups:
        - !Ref FlaskAppSecurityGroup
      IamInstanceProfile: !Ref TerraformIAMRole
      Tags:
        - Key: Name
          Value: FlaskAppServer
________________________________________
Code Snippets
Here are important code snippets included in the project:
CloudFormation for Flask Server:
FlaskAppServer:
  Type: AWS::EC2::Instance
  Properties:
    InstanceType: t2.micro
    ImageId: ami-0c55b159cbfafe1f0
    KeyName: my-key-pair
    SecurityGroups:
      - !Ref FlaskAppSecurityGroup
    IamInstanceProfile: !Ref TerraformIAMRole
    Tags:
      - Key: Name
        Value: FlaskAppServer
Terraform Code for EC2 Instance:
resource "aws_instance" "flask_app" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  key_name               = var.key_name
  security_groups        = [aws_security_group.flask_app_sg.name]
  iam_instance_profile   = "terraform-iam-role"
  tags = {
    Name = "FlaskAppServer"
  }

  associate_public_ip_address = true
}
________________________________________
Conclusion
This project showcases a simple yet powerful solution for deploying a Flask application with Jenkins CI/CD on AWS. With the use of Terraform for provisioning AWS resources, we can easily replicate the setup or extend it with more features like database integration or auto-scaling.

