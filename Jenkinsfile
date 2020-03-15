node{
   stage('SCM Checkout'){
       git credentialsId: 'git-creds', url: 'https://github.com/RAMR645/Assignment2-645.git'
   }
   stage('Mvn Package'){
     def mvnHome = tool name: 'maven-3', type: 'maven'
     def mvnCMD = "${mvnHome}/bin/mvn"
     sh "${mvnCMD} clean package"
   }
   stage('Build Docker Image'){
     sh 'docker build -t swe645/assignment2:dock_img .'
   }
   stage('Push Docker Image'){
     withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
        sh "docker login -u swe645 -p ${dockerHubPwd}"
     }
     sh 'docker push swe645/assignment2:dock_img'
   }

stage('Deploy to K8s'){
  steps{
    sh "chmod +x changeTag.sh"
    sh "./changeTag.sh ${Docker_TAG}"
    sshagent(['kops-machine']) {
    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ubuntu@18.206.230.82:/home/ubuntu/"
     script{
      try{
        sh "ssh ubuntu@18.206.230.82 kubectl apply -f ."
      }catch(error){
        sh "ssh ubuntu@18.206.230.82 kubectl create -f ."
      }
     }
     }
  }

}
}

