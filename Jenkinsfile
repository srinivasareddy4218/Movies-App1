currentBuild.displayName="movies-app-#"+currentBuild.number
pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('Build Docker Image'){
            steps{
                sh "sudo docker build . -t srinivasareddy4218/movies-app:${DOCKER_TAG} "
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId:'dockerpwd', variable:'sree-sample')]) {
                    sh "sudo docker login -u srinivasareddy4218 -p ${sree-sample}"
                    sh "sudo docker push srinivasareddy4218/movies-app:${DOCKER_TAG}"
                }
            }
        }
    }
} 
def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
    }
 
