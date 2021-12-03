resource "azuread_user" "user_principal" {
  for_each = { for user in local.users : user.user_principal_name => user }

  user_principal_name = each.value.user_principal_name
  display_name        = each.value.display_name
  mail_nickname       = each.value.mail_nickname
  password            = random_password.user_random_password.result
}

resource "random_password" "user_random_password" {
  length  = 12
  special = false
}

resource "null_resource" "password_writer" {
  for_each = { for user in local.users : user.user_principal_name => user }
  provisioner "local-exec" {
    command = "echo \"${each.value.display_name} ${azuread_user.user_principal[each.value.user_principal_name].password}\" >> passwords.txt"
  }
}