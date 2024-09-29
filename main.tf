terraform {
       backend "remote" {
         organization = "AshvinNihalani"

         workspaces {
           name = "personal-infrastructure"
         }
       }
     }

resource "null_resource" "example" {
       triggers = {
         value = "A example resource that does nothing!"
       }
   }
