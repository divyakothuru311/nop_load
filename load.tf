resource "aws_lb_target_group" "test" {
  name     = "mytarget"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.qtvpc.id


}
resource "aws_lb" "test" {
  name               = "applb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app.id]
  subnets            = [aws_subnet.subnets.*.id[0], aws_subnet.subnets.*.id[1]]


  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
  depends_on = [aws_instance.appserver,aws_lb_target_group.test]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "5000"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
  depends_on = [aws_lb_target_group.test, aws_lb.test]
}
resource "aws_lb_target_group_attachment" "tg-attach" {
  count            = length(var.ec2_names)
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.appserver.*.id[count.index]
  port             = 5000
}
