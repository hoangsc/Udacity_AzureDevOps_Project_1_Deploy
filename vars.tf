variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "udacity"
}

variable "rgname" {
  description = "The name of the resource group"
  default = "Azuredevops"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "west europe"
}

variable "username" {
  description = "Username to login to the VM"
  default = "vmuser"
}

variable "password" {
  description = "Password for the VM user"
  default = "Passwordac$mki$89"
}

variable "vm-count" {
  description = "Number of VMs"
  default = 2
}

variable "packer_rg" {
  description = "resource group of the packer image"
  default = "Azuredevops"
}

variable "packer_image_name" {
  description = "packer image name"
  default = "myPackerImage"
}

variable "project" {
  description = "Project tag"
  default = "DevOps Project 1"
}