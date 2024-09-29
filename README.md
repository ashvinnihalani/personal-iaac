# Personal Cloud Resources
Personal Repo to Manage Cloud IaaC

## Stack
### HCP Terraform
Note that we have migrated away from Terraform Cloud and are not using the
newer Terraform Cloud.
* State Managment - The state/logs of our deployment runs are stored here
* Secret Managment - All secret managment is managed through Terraform Cloud
* Hosted Plan Executer - A managed runner that executs the generated Terraform plan

### GitHub Actions
GitHub Actions is our CI/CD providers. The actions does a couple of things:
* Init Terraform
* Check to make sure our formating is correct
* Generate plan an upload to the Cloud

## FAQ 
1) Why is there a two step deployment process?
* There is no good reason TBF. Since we are using a hosted runner regardless, there isn't a good reason for why both the GitHub action is hosted on a Github Runner and the Terraform is hosted on the runner. This would be more applicable if I had multiple repos/multiple people that all share the same cloud connections as then all the Cloud Connection credentials could be managed from a single interface while all the Github Actions do is manage their connection to the Terraform. 

