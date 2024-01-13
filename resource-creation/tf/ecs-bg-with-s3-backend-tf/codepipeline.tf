resource "aws_codepipeline" "codepipeline" {
  name     = "ecs-bluegreen-pipeline"
  role_arn = local.codepipeline_full_access_role

  artifact_store {
    location = local.s3_bucket_name
    type     = "S3"

  }

  stage {
    name = "Source"
    action {
      name = "SourceFromCodeCommit"
      category = "Source"
      owner = "AWS"
      provider = "CodeCommit"
      version = "1"
      output_artifacts = ["SourceArtifact"]
      configuration = {
        RepositoryName = var.application_name
        BranchName = "master"
        PollForSourceChanges = "false"
        OutputArtifactFormat = "CODE_ZIP"
      }
    } 

    action {
      name = "SourceFromECR"
      category = "Source"
      owner = "AWS"
      provider = "ECR"
      version = "1"
      output_artifacts = ["ImageArtifact"]
      configuration = {
        RepositoryName = var.application_name
        ImageTag: "latest"
      }
    } 




  }


  stage {
    name = "DeployToECSBlueGreen"
    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "CodeDeployToECS"
      version = "1"
      input_artifacts  = ["SourceArtifact", "ImageArtifact"]
      configuration = {
        ApplicationName = var.application_name
        DeploymentGroupName = var.application_name 
        TaskDefinitionTemplateArtifact = "SourceArtifact"
        AppSpecTemplateArtifact = "SourceArtifact"
        AppSpecTemplatePath  = "appspec.yaml"
        TaskDefinitionTemplatePath = "taskdef.json"
        Image1ArtifactName: "ImageArtifact",
        Image1ContainerName: "IMAGE1_NAME"
      }
    }
  }
}

//Create S3 now
