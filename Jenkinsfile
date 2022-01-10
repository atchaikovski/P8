pipeline {
  agent { label "docker" }
  stages {
    stage("get the code from github") {
      steps {
        git clone https://github.com/atchaikovski/P8.git
      }
    }
    stage("build a nginx docker image") {
      steps {
        sh """
          docker build -t nginx-p8 . 
        """
      }
    }
    stage("start the docker container") {
      steps {
          sh """
            docker run -p 9889:80 --name nginx-project8 -d nginx-p8
          """
      } 
   }
  }
}
