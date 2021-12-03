locals {
  github = {
    org_name = "Kortex"
    repositories = {
      manual = "az-tf-manual"
      staged = "az-tf-staged"
    }
  }
  subscription_id = "d984fd7f-5ebd-4b07-896f-ee6c0ed6c886"

  users = [
    {
      user_principal_name = "akourtesas@dimitrisprapasgmail.onmicrosoft.com"
      display_name        = "Aris Kourtesas"
      mail_nickname       = "akourtesas"
    }
  ]

  stages = [
    "dev",
    "uat",
    "prod"
  ]

}
