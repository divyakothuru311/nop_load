variable "vpc_cidr" {
  type        = string
  description = "this is vpc cidr"
}
variable "subnet_names" {
  type        = list(string)
  description = "these are subnet names"
}
variable "db_subnet_names" {
  type        = list(string)
  description = "these are dbsubnet names"
}
variable "subnet_az" {
  type        = list(string)
  description = "these are az for subnets"
}
variable "public_key_path" {
  type        = string
  description = "this is public key"
}

variable "private_key_path" {
  type        = string
  description = "this is private key"
}

variable "app_subnet_name" {
  type = list(string)
}
variable "ubuntu_ami_id" {
  type        = list(string)
  description = "this is ami id of vm"
}
# variable "ansiblescript" {
#   type        = string
#   description = "this is ansible script"

# }
variable "app_ec2_size" {
  type        = list(string)
  description = "this is size of vm"
}
variable "ec2_names" {
  type        = list(string)
  description = "this are vm names"

}
variable "appsecurity_group_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      from_port  = string
      to_port    = string
      protocol   = string
      cidr_block = string
    }))
  })
  description = "this is app security group"
}
variable "dbsecurity_group_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      from_port  = string
      to_port    = string
      protocol   = string
      cidr_block = string
    }))
  })
  description = "this is db1 security group"
}