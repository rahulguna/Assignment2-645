// SWE 645 Assignment2, Team members: Avinash, Rashi, Rushil, Mithilaesh.
node{
   // This stage is used to checkout the code from GitHub.
   stage('SCM Checkout'){
       git credentialsId: 'git-creds', url: 'https://github.com/RAMR645/Assignment2-645.git'
   }
   // This stage is used to perform maven clean package build, so the war file is created.
   stage('Mvn Package'){
     def mvnHome = tool name: 'maven-3', type: 'maven'
     def mvnCMD = "${mvnHome}/bin/mvn"
     sh "${mvnCMD} clean package"
   }
   // This stage is used to build image using the Dockerfile in this Github repo. The variables are the dockerhub repo/image:tag.
   stage('Build Docker Image'){
      sh 'docker build -t swe645/assignment2:dock_img .'
   }
   // This stage logs into our dockerhub and pushes the built image from the previous to the assignment2 repo with tag dock_img.
   stage('Push Docker Image'){
     withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
        sh "docker login -u swe645 -p ${dockerHubPwd}"
     }
      sh 'docker push swe645/assignment2:dock_img'
   }
  // This stage logs into the ec2 running Kubernetes master node and it copies the yml file into the instance, 
  // then creates and deploys it to the pod for the fisttime. If the pods already exsists, 
  // it will apply the changes made to the exsisting image. So the latest applicaiton will be running.
stage('Deploy to K8s'){
    sshagent(['kops-machine']) {
    sh "scp -o StrictHostKeyChecking=no services.yml pods.yml ubuntu@54.234.176.195:/home/ubuntu/"
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


