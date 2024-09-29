terraform {
       backend "remote" {
         organization = "AshvinNihalani"

         workspaces {
           name = "personal-infrastructure"
         }
       }
     }
