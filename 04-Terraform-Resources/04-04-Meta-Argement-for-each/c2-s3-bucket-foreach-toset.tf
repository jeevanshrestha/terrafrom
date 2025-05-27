# Create 4 IAM Users

resource "aws_iam_user" "my_iam_users" {

  #for_each with toset
  for_each = toset(["TJason", "Pason", "Rason", "Sason"])

  name = "${each.value}-user"

  # permissions_boundary = "arn:aws:iam::aws:policy/AdministratorAccess"  

  tags = {
    Name = "${each.value}-user"
  }
} 