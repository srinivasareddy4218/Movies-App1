currentBuild.displayName="movies-app-#"+currentBuild.number
pipeline {
    agent any
     stages{
        stage('Build Docker Image'){
            steps{
                sh "sudo docker build . -t srinivasareddy4218/movies-app:${BUILD_ID} "
            }
        }
        stage('DockerHub Push'){
            steps{
               withCredentials([string(credentialsId: 'sree-dockerpwd', variable: 'sample')]) {
                    sh "sudo docker login -u srinivasareddy4218 -p ${sample}"
                    sh "sudo docker push srinivasareddy4218/movies-app:${BUILD_ID}"
                }
            }
        }
        stage("Deploy To Kuberates Cluster"){
		steps{	
	 withCredentials([file(credentialsId: 'demo-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
         sh "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
         sh "gcloud config set project mssdevops-284216"
         sh "gcloud config set compute/zone us-central1-c"
         sh "gcloud config set compute/region us-central1"
         sh "gcloud container clusters get-credentials cluster-1 --zone us-central1-c --project mssdevops-284216"			
          /**frontend **/			
	  sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' frontend/deployment/frontend-deployment.yaml"
	  sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f frontend/deployment/frontend-deployment.yaml"
         
          sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' frontend/deployment/frontend-service.yaml"
	  sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f frontend/deployment/frontend-service.yaml"
	
	/** Backend **/
          sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' backend/deployment/backend-deployment.yaml"
	   sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f backend/deployment/backend-deployment.yaml"
			
           sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' backend/deployment/backend-service.yaml"
	   sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f backend/deployment/backend-service.yaml"
      
	  /** database **/
			
	  sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' database/deployment/database-deployment.yaml"
          sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f database/deployment/database-deployment.yaml"
			
          sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' database/deployment/database-service.yaml" 
	  sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f database/deployment/database-service.yaml"
	
      }

   }
 } 
}	
