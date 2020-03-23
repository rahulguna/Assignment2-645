def getDockerTag() {
    def tag = sh script: 'git rev-parse HEAD' , returnStdout: true
      return tag
   }
node{
   environment {
    DOCKER_TAG = getDockerTag()  
   }
   stage('SCM Checkout'){
       git credentialsId: 'git-creds', url: 'https://github.com/RAMR645/Assignment2-645.git'
   }
   stage('Mvn Package'){
     def mvnHome = tool name: 'maven-3', type: 'maven'
     def mvnCMD = "${mvnHome}/bin/mvn"
     sh "${mvnCMD} clean package"
   }
   stage('Build Docker Image'){
      sh "docker build -t swe645/assignment2:${DOCKER_TAG}"
   }
   stage('Push Docker Image'){
     withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
        sh "docker login -u swe645 -p ${dockerHubPwd}"
     }
      sh "docker push swe645/assignment2:${DOCKER_TAG}"
   }

stage('Deploy to K8s'){
   sh "chmod -x ChangeTag.sh"
   sh "./ChangeTag.sh ${DOCKER_TAG}"
    sshagent(['kops-machine']) {
    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ubuntu@54.234.176.195:/home/ubuntu/"
       script{
          try{
           sh "ssh ubuntu@54.234.176.195 kubectl create -f /home/ubuntu/"  
          }catch(error){
             sh "ssh ubuntu@54.234.176.195 kubectl apply -f /home/ubuntu/"
          }
       }   
    }
 }
}


