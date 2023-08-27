# data "aws_subnets" "database" {
#   filter {
#     name   = "tag:Name"
#     values = var.db_subnet_names
#   }
#   depends_on = [aws_subnet.subnets]
# }
# resource "aws_db_subnet_group" "group" {
#   subnet_ids = data.aws_subnets.database.ids
#   name       = "dbgroup"
#   tags = {
#     Name = "dbsg"
#   }
#   depends_on = [
#     aws_subnet.subnets,
#     data.aws_subnets.database
#   ]
# }
# resource "aws_db_instance" "ntierdb" {
#   allocated_storage    = 20
#   db_name              = "mydb"
#   engine               = "mysql"
#   engine_version       = "8.0"
#   instance_class       = "db.t3.micro"
#   username             = "admin"
#   password             = "adminadmin"
#   skip_final_snapshot  = true
#   db_subnet_group_name = aws_db_subnet_group.group.name
#   identifier           = "ntier"
# }
