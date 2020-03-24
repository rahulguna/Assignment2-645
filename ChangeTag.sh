#SWE 645 Assignment2, Team members: Avinash[G01163980], Rashi[G01225299], Rushil[G01203932], Mithilaesh[G01206238].

#it adds new tag version for each build made and deployed to pods

sed "s/tagVersion/$1/g" pods.yml > node-app-pod.yml
