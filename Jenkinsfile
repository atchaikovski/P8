pipeline {
    agent { label 'docker' }

    tools {
        git 'Default'
    }

    stages {
        stage('cleanup docker env') {
            steps {
                sh 'docker ps -q -f status=running | xargs --no-run-if-empty docker stop'
                sh 'docker ps -q -f status=exited | xargs --no-run-if-empty docker rm'
                sh 'docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi'            
            }
        }
        stage('Clone from Github') {
            steps {
                git branch: 'main', url: 'https://github.com/atchaikovski/P8.git'
            }
        } 
        stage('Build container') {
            steps {
                sh 'docker build -t nginx-p8 .' 
            }
        }
        stage('run nginx container') {
            steps {
                sh 'docker run --rm -p 9889:80 -d --name nginx-project8 nginx-p8'
            }
        }
        stage('liveness probe') {
            steps {
                sh '''
                   r=`curl -s localhost:9889/alive | grep "alive"`
                   if [ $r = '' ]; then
                        echo 'something wrong, error!'
                     else
                        echo 'liveness passed ok'
                   fi
                   '''
            }
        }
        stage('check MD5--- wont work') {
            steps {
                sh 'echo md5sum.txt'
            }
        }
        stage('cleanup...') {
            steps {
                sh 'docker ps -q -f status=running | xargs --no-run-if-empty docker stop'
                sh 'docker ps -q -f status=exited | xargs --no-run-if-empty docker rm'
                sh 'docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi'            
            }
        }
    }
  post {
      failure {
         slackSend channel: 'pet-projects', message: 'Failure of docker build and run', teamDomain: 'alexsworkspac-nf14913', tokenCredentialId: 'slack-token'
      }
      success {
         slackSend channel: 'pet-projects', message: 'Success of docker build and run', teamDomain: 'alexsworkspac-nf14913', tokenCredentialId: 'slack-token'
      }
  }
}
