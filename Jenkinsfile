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
               withCredentials([string(credentialsId: 'sree-docker', variable: 'sample')]) {
                    sh "sudo docker login -u srinivasareddy4218 -p ${sample}"
                    sh "sudo docker push srinivasareddy4218/movies-app:${BUILD_ID}"
                }
            }
        }
        stage("Deploy To Kuberates Cluster"){
		steps{
          sshagent(['sshkey']){
	 sh 'ssh -t -t cloud_user@40.117.94.170 -o StrictHostKeyChecking=no'	  
	   	  
          /**frontend **/
	withCredentials([kubeconfigContent(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_CONTENT')]){
	 sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' frontend/deployment/frontend-deployment.yaml"
	  sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f frontend/deployment/frontend-deployment.yaml -n msslabs"
         
          sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' frontend/deployment/frontend-service.yaml"
	  sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f frontend/deployment/frontend-service.yaml -n msslabs"
	
	/** Backend **/
          sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' backend/deployment/backend-deployment.yaml"
	   sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f backend/deployment/backend-deployment.yaml -n msslabs"
			
           sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' backend/deployment/backend-service.yaml"
	 sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f backend/deployment/backend-service.yaml -n msslabs"
      
	  /** database **/
			
	  sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' database/deployment/database-deployment.yaml"
          sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f database/deployment/database-deployment.yaml -n msslabs"
			
          sh "sed -i -e 's,image_to_be_deployed,'srinivasareddy4218/movies-app:${BUILD_ID}',g' database/deployment/database-service.yaml" 
	  sh "export KUBECONFIG=/etc/kubernetes/admin.conf && kubectl apply -f database/deployment/database-service.yaml -n msslabs"
	
      
    }
    }			
   } 
  }
 }
}	

