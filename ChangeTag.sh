#SWE 645 Assignment2, Team members: Avinash, Rashi, Rushil, Mithilaesh.

#it adds new tag version for each build made and deployed to pods

sed "s/tagVersion/$1/g" pods.yml > node-app-pod.yml
