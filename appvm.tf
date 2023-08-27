resource "aws_key_pair" "idrsa" {
  key_name   = "workshop"
  public_key = file(var.public_key_path)
  tags = {
    CreatedBy = "terraform"
  }
}
# data "aws_subnet" "app" {
#   filter {
#     name   = "tag:Name"
#     values = ["app"]
#   }
#   depends_on = [aws_subnet.subnets]
# }
# data "aws_subnet" "app1" {
#   filter {
#     name   = "tag:Name"
#     values = ["app1"]
#   }


#   depends_on = [
#     aws_subnet.subnets
#   ]
# }

resource "aws_instance" "appserver" {
  count                       = length(var.ec2_names)
  ami                         = var.ubuntu_ami_id[count.index]
  associate_public_ip_address = true
  instance_type               = var.app_ec2_size[count.index]
  key_name                    = aws_key_pair.idrsa.key_name
  vpc_security_group_ids      = [aws_security_group.app.id]
  subnet_id                   = aws_subnet.subnets.*.id[count.index]
  // user_data                   = file(var.ansiblescript)
  tags = {
    Name = var.ec2_names[count.index]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }



  provisioner "file" {
    source      = "nop-playbook.yaml"
    destination = "/tmp/nop-playbook.yaml"
  }
  provisioner "file" {
    source      = "nopcommerce.service"
    destination = "/tmp/nopcommerce.service"
  }
  provisioner "file" {
    source      = "default"
    destination = "/tmp/default"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install software-properties-common -y",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "ansible-playbook -i hosts /tmp/nop-playbook.yaml"
    ]
  }


  depends_on = [
    aws_subnet.subnets
  ]
}
