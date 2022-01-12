pipeline {
    agent {
        label "docker"
        docker { image 'nginx' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'nginx --version'
            }
        }
    }
}