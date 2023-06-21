pipeline {
    agent any

    triggers 
    {
        // The pipeline is triggered every minute to check for changes in the git
        pollSCM('*/1 * * * *')
    }

    environment 
    {
        testip = sh(script: "aws ec2 describe-instances --region eu-central-1 --filters 'Name=tag:Environment,Values=Test' --query 'Reservations[].Instances[].PublicIpAddress' --output text", returnStdout: true).trim()
        // PROD_IP = sh(script: "aws ec2 describe-instances --region eu-central-1 --filters Name=tag:platform,Values=production --query 'Reservations[].Instances[].PublicIpAddress' --output text", returnStdout: true).trim()
    }
    
    stages {
        
        stage('Cleanup') {
            steps {
                echo "Cleaning up..."
                sh 'rm -rf *'
            }
        }

        stage('Clone') {
            steps {
                echo "Cloning repository..."
                sh 'git clone https://github.com/Gihan4/DevOps-Crypto.git'
                sh 'ls'
            }
        }

        stage('Build') {
            steps {
                echo "Building..."
                sh 'echo Packaging'
                sh 'tar -czvf project.tar.gz DevOps-Crypto'
                sh 'ls'
            }
        }

        stage('Upload to S3') 
        {
            steps 
            {
                    echo "Copying to S3..."
                    sh 'aws s3 cp project.tar.gz s3://gihansbucket'       
            }
        }

        stage('Pull gzip from S3 and push to EC2') 
        {
            steps 
                {
                    sh 'echo "copying S3 object to ec2..."'
                    sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Gihan4.pem ec2-user@${testip} 'aws s3 cp s3://gihansbucket/project.tar.gz .'"
                }
        } 

        stage('Testing') 
        {
            steps 
            {
                sh """
                ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Gihan4.pem ec2-user@${testip} 'tar -xvf /home/ec2-user/project.tar.gz ;rm project.tar.gz ;/bin/bash ./Devops-Crypto/Ansible/deploy.sh'
                """
            }
        }
    }
}



        
