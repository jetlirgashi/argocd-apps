output "password" {
  value = aws_iam_user_login_profile.example.password
}

output "username" {
  value = aws_iam_user.this.name
}
