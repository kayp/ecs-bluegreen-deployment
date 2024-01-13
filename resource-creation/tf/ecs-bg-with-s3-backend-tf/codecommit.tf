resource "aws_codecommit_repository" "code_commit_repo" {
  repository_name = var.application_name
}

locals {
  code_commit_repo_name = aws_codecommit_repository.code_commit_repo.repository_name

}
