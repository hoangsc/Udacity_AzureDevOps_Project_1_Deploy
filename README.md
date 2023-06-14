# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
## Create and Apply a Tagging Policy
Open terminal end loggin to Azure with command:
``
az login
``

Create the Policicy Definition:

``
az policy definition create 
    --name tagging-policy 
    --display-name "Indexed Resources must have tags" 
    --description "Policy to enforce tagging on all indexed resources" 
    --rules taggingpolicy.rules.json 
    --params taggingpolicy.param.json 
    --mode Indexed
``

Create the Policy Assignment
``
az policy assignment create 
    --name tagging-policy-assignment 
    --display-name "tagging assignment" 
    --policy tagging-policy 
    --params "{ "tagName": {"value": "Project"} }"
``
Refer to the command in [taggingpolicy.azcli].

To check the result:
``
az policy
``
## Output:
Refer screenshoot in [screenshoots/az_policy_assignment_list.png]

## Create a Server Image
Open terminal end loggin to Azure with command:
``
az login
``
Go to Azure portal to get Service Principal Detail and replace your infomations to `client_id`. `client_secret`, `subscription_id`, `tenant_id` values in [server.json] template.

Build the template to create an Image in Azure:
``
packer build server.json
``

## Output
Refer screenshoot in [screenshoots/packer_build_result.png]

## Create the infrastructure with Terraform template

Ensure you are working in the directory that contains the Terraform configuration files.
Run command:
``
terraform init
``

Customize varriables in [terraform.tfvars]
- prefix
  - The prefix that gets added to all resources
- rgname
  - The name of the resource group 
- location
  - The Azure region the resource group
- username
  - The username of the VMs' admin user
- password
  - The admin user's password
- vm-count
  - The number of VMs that you want to create
- packer_rg
  - The name of the resource group you created the Packer image in. 
  *Ensure that field match the `managed_image_resource_group_name` value in [server.json]
- packer_image_name
  - The name of the Packer image. 
  *Ensure that fieldmatch the `managed_image_name` value in [server.json]
- project
  - The project name that gets added as a tag to all resources
** In the case you already create the resouce group, you need to import existing resouce group with command:
``
az group show -n 'resouce-group-name'
``
Get the value of Id and import to terraform with command below (replace your subcriptions):

``
terraform import "azurerm_resource_group.main" "/subscriptions/7de72e36-dc87-4e3f-aa67-6dacbc9993c6/resourceGroups/Azuredevops"
``

Create terraform output plan:
``
terraform plan --out solution.plan
``

Apply terraform ouput plan
``
terraform apply "solution.plan"
``

To delete the resouces, run command:
``
terraform destroy
``

Check the result of resource group in Azure portal

## Output

Refer screenshoot in 
[screenshoots/terraform_result.png]
[screenshoots/terraform_apply.png]
[screenshoots/terraform_plan_result.png]
[screenshoots/terraform_import_exsisting_resouce_group.png]