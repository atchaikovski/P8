pipeline {
    agent { label 'docker' }

    tools {
        git 'Default'
    }

    stages {
        stage('Stop running containers') {
            steps {
                sh 'docker ps -q -f status=running | xargs --no-run-if-empty docker stop'
            }
        }
        stage('Remove dangling Containers') {
            steps {
                sh 'docker ps -q -f status=exited | xargs --no-run-if-empty docker rm'
            }
        }
        stage('Delete dangling Images') {
            steps {
                sh 'docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi'
            }
        }
        stage('clone source') {
            steps {
                git branch: 'main', url: 'https://github.com/atchaikovski/P8.git'
            }
        } 
        stage('Get md5 sum') {
            steps {
                sh 'md5sum ./index.html | awk \'{print $1}\' >md5sum.txt'
                sh 'cat md5sum.txt >>index.html'
            }
        } 
        stage('Build') {
            steps {
                dockerfile {
                    filename 'Dockerfile'
                    dir '.'
                    label 'nginx-p8'
                } 
            }
        }
        stage('run nginx container') {
            steps {
                sh 'docker run -p 9889:80 -d --name nginx-project8 nginx-p8'
            }
        }
        stage('liveness probe') {
            steps {
                sh '''
                   r=`curl -i -v localhost:9889/alive | grep "alive"`
                   if [ $r = '' ]; then
                     echo 'something wrong, error!'
                   fi
                   '''
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
