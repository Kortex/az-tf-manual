resource "azuread_user" "user_principal" {
  for_each = local.users

  user_principal_name = each.value.user_principal_name
  display_name        = each.value.display_name
  mail_nickname       = each.value.mail_nickname
  password            = random_password.user_random_password.result
}

resource "random_password" "user_random_password" {
  for_each = local.users
  length  = 12
  special = false
}

resource "null_resource" "password_writer" {
  for_each = local.users
  provisioner "local-exec" {
    command = "echo \"${each.value.display_name} ${random_password.user_random_password.result}\" >> passwords.txt"
  }
}