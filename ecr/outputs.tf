output "ecr" {
  value = aws_ecr_repository.repo.repository_url
}