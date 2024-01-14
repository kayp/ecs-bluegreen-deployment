# Create an ECS Blue-Green deployment

This project converts the instructions provided on  [AWS Create Pipeline for ECR to ECS Deployment](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-ecs-ecr-codedeploy.html) into terraform code. Eventually a pipeline that can perform a Blue-Green deployment of an ECS Cluster is created.


### Following resources were created by terraform 

#### CICD Infrastructure
 1. S3 Buckets for Deployment
 2. IAM Roles
 3. Code Commit
 4. Code Deploy
 5. Code Pipeline
 6. ECR Repo's
 7. S3 Buckets for backend Terraform state

#### Application Infrastructure
 1. Load balancers, target groups, listeners
 2. ECS Task, Service and Cluster 
 3. ECR Repo
 4. Related IAM Roles

### IaC tools
Terraform was used to create all resources. Two options are provided
-  Create local Terraform Backend
-  Create remote Terraform Backend State in S3

## Folder Structure

Deployment instructions

Assuming S3 Backend is being used

1. <b>Create Terrraform Backend"</b> Go to folder - [backend-s3-tf](resource-creation/tf/backend-s3-tf)

```
cd resource-creation/tf/backend-s3-tf

## Edit terraform.tfvars with appropriate values

## run standard terraform commands
terraform init
terraform plan
terraform apply -auto-approve

## Capture the output values. Copy the S3 bucket name that is printed out


```

2. <b> Create the ECR Repo</b> Go to folder - [ecs-bg-ecr-pre-req-1](resource-creation/tf/ecs-bg-ecr-pre-req-1)


```
cd resource-creation/tf/ecs-bg-ecr-pre-req-1

## Edit terraform.tfvars with appropriate values

## run standard terraform commands
terraform init
terraform plan
terraform apply -auto-approve

## Go to ECR Service page on AWS Console page and verify the repo is created- you will need to copy push commands


```

3. <b>Create Docker Images</b> Go to folder - [docker](resource-creation/docker) <br>

There are two Dockerfiles. For simplicity one is a basic Nginx webserver and the other is Apache (httpd) webserver.
For this we first deploy the httpd docker image through ECS. The Blue green deployment replaces it with the nginx image. Detailed instructions to push the images to ECR are available on [AWS ECR userguide](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html)


```
## Dockerfile




```





1. Step-1 to create S3 Bucket for backend state (optional)
2. Step-2 to create Load balancer, ECS and ECR services 
3. Step-3 CICD Pipelines 

## Create S3 Bucket for Backend
