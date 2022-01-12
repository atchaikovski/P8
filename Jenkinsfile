node {
  label 'docker'  
  stage 'Building image'
  git branch: 'main', url: 'https://github.com/atchaikovski/P8.git'

  def newApp = docker.build "nginx-p8:${env.BUILD_ID}"
  stage 'Test image'

}