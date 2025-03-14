pipeline {
    agent any

    environment {
        EC2_USER = "ubuntu"  // 'ubuntu' for Ubuntu AMI; change if needed
        EC2_IP = "18.130.106.251" // Flask EC2 IP
        SSH_CREDENTIALS = 'flask-ec2-key'  // ID for Jenkins SSH key credential
        GITHUB_REPO = 'https://github.com/rajeevgithub007/arqivatech.git'
    }

    stages {
        stage('Clone Repo with PAT') {
            steps {
                withCredentials([string(credentialsId: 'arqivasecret', variable: 'GITHUB_PAT')]) {
                    sh """
                       git clone https://${GITHUB_PAT}@github.com/rajeevgithub007/arqivatech.git
                    """
                }
            }
        }

        // stage('Deploy Flask App') {
        //     steps {
        //         echo "Deploying Flask App to EC2"
        //         sshagent (credentials: ["${env.SSH_CREDENTIALS}"]) {
        //             sh """
        //                 echo "Transferring Flask app..."
        //                 scp -o StrictHostKeyChecking=no -r ./app ${EC2_USER}@${EC2_IP}:/var/www/html/

        //                 echo "Installing Python dependencies..."
        //                 ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} '
        //                     sudo pip3 install -r /var/www/html/app/requirements.txt
        //                 '

        //                 echo "Setting up Flask app with Gunicorn..."
        //                 ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} '
        //                     sudo chmod +x /var/www/html/app/scripts/start_flash.sh &&
        //                     sudo pkill gunicorn || true  # Stop any running instance if exists
        //                     sudo /var/www/html/app/scripts/start_flash.sh
        //                 '
        //             """
        //         }
        //     }
        // }
    }

    post {
        success {
            echo "✅ Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}
