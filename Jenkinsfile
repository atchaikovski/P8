pipeline {
    agent { label 'docker' }
    stages {
            stage('cleanup docker env') {
                steps {
                    sh 'docker ps -q -f status=running | xargs --no-run-if-empty docker stop'
                    sh 'docker ps -q -f status=exited | xargs --no-run-if-empty docker rm'
                    sh 'docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi'            
                }
            }

            stage('Build') {
                steps {
                git branch: 'main', url: 'https://github.com/atchaikovski/P8.git'
                sh 'md5sum ./index.html | awk \'{print $1}\' >>index.html'
                def myEnv = docker.build 'nginx-p8:${env.BUILD_TAG}'  
                }
            }

            stage('Run nginx container') {
            steps {
                sh 'docker run -p 9889:80 -d --name nginx-project8 nginx-p8'
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
    }
}
