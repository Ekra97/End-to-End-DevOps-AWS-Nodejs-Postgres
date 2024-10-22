#!/bin/bash

# Variables
#REGION="eu-west-3" #Make sure it is the same in the terraform variables
#REPOSITORY_NAME="nodejs-app" # If you wanna change the repository name make sure you change it in the k8s/app.yml (Image name) 

aws ecr list-images --repository-name $REPOSITORY_NAME --region $REGION --query 'imageIds[*]' --output json | \
jq -r '.[] | @base64' | \
while read -r image_id_base64; do
    image_id=$(echo $image_id_base64 | base64 --decode)
    echo "Deleting image: $image_id"
    aws ecr batch-delete-image --repository-name $REPOSITORY_NAME --region $REGION --image-ids "imageDigest=$(echo $image_id | jq -r .imageDigest)"
done
