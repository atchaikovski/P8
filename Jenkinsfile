pipeline {
    agent { label 'docker' }

    stages {
        stage('clone source') {
            steps {
                git branch: 'main', url: 'https://github.com/atchaikovski/P8.git'
            }
        } 
        stage('Build') {
            steps {
                sh 'docker build -t nginx-p8 .'
            }
        }
        stage('run nginx container') {
            steps {
                sh 'docker run -p 9889:80 -d --name nginx-project8 nginx-p8'
            }
        }
        stage('Slack') {
            steps {
              slackSend channel: 'pet-projects', message: 'Success of docker build and run', teamDomain: 'alexsworkspac-nf14913', tokenCredentialId: 'new_slack_token'
            }  
        }      
    }
}
