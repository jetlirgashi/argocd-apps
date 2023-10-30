resource "aws_iam_user" "this" {
  name = var.user_name
  path = "/"
}

resource "aws_iam_user_login_profile" "example" {
  user                    = aws_iam_user.this.name
  password_reset_required = true

  lifecycle {
    ignore_changes = [ password_reset_required ]
  }
}

resource "aws_iam_user_group_membership" "example1" {
  user = aws_iam_user.this.name

  groups = [
    "training-memberships"
  ]
}
