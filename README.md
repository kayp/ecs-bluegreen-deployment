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

1. Step-1 to create S3 Bucket for backend state (optional)
2. Step-2 to create Load balancer, ECS and ECR services 
3. Step-3 CICD Pipelines 

## Create S3 Bucket for Backend
