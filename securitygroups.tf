
resource "aws_security_group" "app" {
  name        = var.appsecurity_group_config.name
  description = var.appsecurity_group_config.description
  vpc_id      = aws_vpc.qtvpc.id
  depends_on  = [aws_vpc.qtvpc]
  tags = {
    Name = local.app
  }
}
resource "aws_security_group_rule" "app1" {
  count             = length(var.appsecurity_group_config.rules)
  security_group_id = aws_security_group.app.id
  type              = var.appsecurity_group_config.rules[count.index].type
  from_port         = var.appsecurity_group_config.rules[count.index].from_port
  to_port           = var.appsecurity_group_config.rules[count.index].to_port
  protocol          = var.appsecurity_group_config.rules[count.index].protocol
  cidr_blocks       = [var.appsecurity_group_config.rules[count.index].cidr_block]
  depends_on        = [aws_security_group.app]
}
resource "aws_security_group" "db" {
  name        = var.dbsecurity_group_config.name
  description = var.dbsecurity_group_config.description
  vpc_id      = aws_vpc.qtvpc.id
  depends_on  = [aws_vpc.qtvpc]
  tags = {
    Name = local.db
  }
}
resource "aws_security_group_rule" "rds" {
  count             = length(var.dbsecurity_group_config.rules)
  security_group_id = aws_security_group.db.id
  type              = var.dbsecurity_group_config.rules[count.index].type
  from_port         = var.dbsecurity_group_config.rules[count.index].from_port
  to_port           = var.dbsecurity_group_config.rules[count.index].to_port
  protocol          = var.dbsecurity_group_config.rules[count.index].protocol
  cidr_blocks       = [var.dbsecurity_group_config.rules[count.index].cidr_block]
  depends_on        = [aws_security_group.db]
}

