vpc_cidr         = "10.10.0.0/16"
subnet_names     = ["app", "app1", "db", "db1"]
subnet_az        = ["ap-south-1a", "ap-south-1b", "ap-south-1a", "ap-south-1b"]
db_subnet_names  = ["db", "db1"]
public_key_path  = "~/.ssh/id_rsa.pub"
app_subnet_name  = ["app", "app1"]
app_ec2_size     = ["t2.micro", "t2.micro"]
ec2_names        = ["appserver1", "appserver2"]
ubuntu_ami_id    = ["ami-0f5ee92e2d63afc18", "ami-0f5ee92e2d63afc18"]
private_key_path = "~/.ssh/id_rsa"
//ansiblescript    = "./installansible.sh"


appsecurity_group_config = {
  name        = "appsg"
  description = "this is appsg"
  rules = [{
    type       = "ingress"
    from_port  = 5000
    to_port    = 5000
    protocol   = "Tcp"
    cidr_block = "0.0.0.0/0"
    },
    {
      type       = "ingress"
      from_port  = 22
      to_port    = 22
      protocol   = "Tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      type       = "egress"
      from_port  = 0
      to_port    = 65535
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
}
dbsecurity_group_config = {
  name        = "dbsg"
  description = "this is dbsg"
  rules = [{
    type       = "ingress"
    from_port  = 3306
    to_port    = 3306
    protocol   = "Tcp"
    cidr_block = "0.0.0.0/0"
    },
    {
      type       = "ingress"
      from_port  = 22
      to_port    = 22
      protocol   = "Tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      type       = "egress"
      from_port  = 0
      to_port    = 65535
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
}