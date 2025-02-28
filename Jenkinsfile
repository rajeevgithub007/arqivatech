pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
        FLASK_APP_INSTANCE_IP = '${FlaskAppServerPublicIP}'  // Replace with the actual Flask instance IP
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/rajeevgithub007/arqivatech.git' // Replace with the actual Git repository URL
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Deploy Flask App') {
            steps {
                script {
                    // Copy application files to the Flask app server
                    sh "scp -i ~/.ssh/my-key.pem -r app/* ec2-user@${FLASK_APP_INSTANCE_IP}:/var/www/html"
                    
                    // Restart the Flask app service on the EC2 instance
                    sh "ssh -i~/.ssh/my-key.pem ec2-user@${FLASK_APP_INSTANCE_IP} 'sudo systemctl restart flask-app.service'"
                }
            }
        }
    }
}
