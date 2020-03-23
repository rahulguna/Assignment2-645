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
    sshagent(['kops-machine']) {
    sh "ssh ubuntu@54.234.176.195 kubectl run mypod --image=docker.io/swe645/assignment2:dock_img --port=8080"
    sh "ssh ubuntu@54.234.176.195 kubectl expose deployment mypod --type=LoadBalancer --port=8080 --target-port=8080"   
    }
 }
}

