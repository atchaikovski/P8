pipeline {
    agent { label 'docker' }
    tools {
        git 'Default'
    }
    stages {
        stage('Dangling Containers') {
            steps {
                sh 'docker ps -q -f status=exited | xargs --no-run-if-empty docker rm'
            }
        }

        stage('Dangling Images') {
            steps {
                sh 'docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi'
            }
        }

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
    }
  post {
      success {
         slackSend channel: 'pet-projects', message: 'Success of docker build and run', teamDomain: 'alexsworkspac-nf14913', tokenCredentialId: 'new_slack_token'
      }
  }
}
