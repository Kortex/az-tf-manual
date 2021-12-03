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

# Create the app registrations for each stage
resource "azuread_application" "app_registration" {
  for_each     = local.stages
  display_name = "sample-app-${each.key}"
}
# Create the service principals for each app registration
resource "azuread_service_principal" "service_principal" {
  for_each       = local.stages
  application_id = azuread_application.app_registration[each.key].application_id
}
# Create the service principal passwords
resource "azuread_service_principal_password" "service_principal_password" {
  for_each             = local.stages
  service_principal_id = azuread_service_principal.service_principal[each.key].id
}
# Give each SP the Contributor role on its own subscription
resource "azurerm_role_assignment" "service_principal_contributor_role" {
  for_each = local.stages
  principal_id = azuread_service_principal.service_principal[each.key].id
  scope = data.azurerm_subscription.subscription.id
  role_definition_name = "Contributor"
}

data "azurerm_subscription" "subscription" {
  subscription_id = local.subscription_id
}
