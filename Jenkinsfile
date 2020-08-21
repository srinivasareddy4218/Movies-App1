pipeline {
    agent any
    environment {
        // comment added
         APPLICATION = 'app'
         ENVIRONMENT = 'dev'
         MAINTAINER_NAME = 'jenkins'
         MAINTAINER_EMAIL = 'jenkins@email.com'
    }
      stages {
         stage('clone repository') {
             steps {
                 // cloning repo
                 git credentialsId: 'sree-github', url: 'https://github.com/srinivasareddy4218/Movies-App1.git'
             }
         }
         stage('Build Docker Image'){
            steps{
                sh "sudo docker build . -t srinivasareddy4218/movies-app:${BUILD_ID} "
            }
        }
        stage('DockerHub Push'){
            steps{
               withCredentials([string(credentialsId: 'sree-docker', variable: 'sample')]) {
                    sh "sudo docker login -u srinivasareddy4218 -p ${sample}"
                    sh "sudo docker push srinivasareddy4218/movies-app:${BUILD_ID}"
                }
            }
        }
         stage('Build Image') {
             steps {
                 script {
                     sshagent(credentials : ['sshkey']) {
                        sh "echo pwd"
                        sh 'ssh -t -t azureuser@40.117.94.170 -o StrictHostKeyChecking=no'
                        sh "echo pwd"
                        sh 'sudo -i -u root'
                        sh 'cd /opt/docker/web'
                        sh 'echo pwd'
                    }
                 }
             }
         }
     }
}
