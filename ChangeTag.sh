#SWE 645 Assignment2, Team members: Avinash, Rashi, Rushil, Mithilaesh.

#it direct to the pod.yml file

sed "s/tagVersion/$1/g" pods.yml > node-app-pod.yml
