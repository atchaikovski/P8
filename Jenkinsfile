pipeline {
  agent { label "docker" }
  stages {
    stage("get the code from github") {
      steps {
        git clone 
      }
    }
    stage("build a nginx docker image") {
      steps {
        sh """
          docker build -t nginx-p8 . 
        """
      }
    }
    stage("get the code from github") {
      steps {
          sh """
            git clone 
          """
      } 
   }
  }
}
