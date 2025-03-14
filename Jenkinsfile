pipeline {
    agent any

    environment {
        EC2_USER = "ubuntu"
        EC2_IP = "18.130.106.251"
        SSH_CREDENTIALS = 'flask-ec2-key'
        GITHUB_REPO = 'https://github.com/rajeevgithub007/arqivatech.git'
        LOCAL_REPO_DIR = 'arqivatech'
    }

    stages {
        stage('Clone Repo with PAT if Not Exists') {
            steps {
                withCredentials([string(credentialsId: 'arqivasecret', variable: 'GITHUB_PAT')]) {
                    sh """
                        if [ ! -d "\$LOCAL_REPO_DIR" ]; then
                            echo "Cloning repository as it does not exist locally..."
                            git clone https://${GITHUB_PAT}@github.com/rajeevgithub007/arqivatech.git
                        else
                            echo "Repository already exists. Skipping clone."
                        fi
                    """
                }
            }
        }

        stage('Deploy Flask App') {
    steps {
        echo "Deploying Flask App to EC2"
        script {
            sshagent (credentials: [env.SSH_CREDENTIALS]) {
                sh '''
                    echo "Transferring Flask app to EC2..."
                    rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no" ./arqivatech/app/ ${EC2_USER}@${EC2_IP}:/home/ubuntu/app/

                    echo "Moving app to /var/www/html/app..."
                    ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} "
                        sudo rm -rf /var/www/html/app &&
                        sudo mv /home/ubuntu/app /var/www/html/
                    "

                    echo "Installing Python dependencies..."
                    ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} "
                        sudo pip3 install -r /var/www/html/app/requirements.txt
                    "

                    echo "Restarting Gunicorn..."
                    ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} "
                        sudo chmod +x /var/www/html/app/scripts/start_flask.sh &&
                        sudo pkill gunicorn || true &&
                        sudo /var/www/html/app/scripts/start_flask.sh
                    "
                '''
            }
        }
    }
  }
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
