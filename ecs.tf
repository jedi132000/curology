provider "aws" {
  region = "us-east-2"
  access_key = ""
  secret_key = ""
}

module "ecs" {
  source = "modules/ecs"

  environment          = "${var.environment}"
  cluster              = "${var.environment}"
  cloudwatch_prefix    = "${var.environment}"           #See ecs_instances module when to set this and when not!
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnet_cidrs  = "${var.public_subnet_cidrs}"
  private_subnet_cidrs = "${var.private_subnet_cidrs}"
  availability_zones   = "${var.availability_zones}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  key_name             = "${aws_key_pair.ecs.key_name}"
  instance_type        = "${var.instance_type}"
  ecs_aws_ami          = "${var.ecs_aws_ami}"
}

resource "aws_key_pair" "ecs" {
  key_name   = "ecs-key-${var.environment}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtchs4s6c7tQimh/9mGyr8xP5YtVtR9k5E82B3YlTGt787Z0oo8I7nqcG+1rs4CMtoFdFEnwF2kpiTH5mlLtYmu//QMRzdYpS1pjXhfOd56rMJRuW4Ofrys1iS57PND9bOPl6iyKWwStd7g1JiU3NMutiNGZcmgO6vWpY1+GRcfM+p9kV603egcNTf/SKJDQanGNft/4VaR48WPx3L9tyVEXI11jUk5l81XBfMbB8omON/5blotFzfT7+o/WPsq00IZm5FZFSlAokjzbkQWERIASYk5h8rpeXe2Y8H2nfZeBQwwgtCN1HlGBdBESocF58XA9X+PNUId4PMFU9rrqLaCk8WO2zP8KzE6pGNuJpp30gWu/SRl2V88CP5/TJ+72iZ2UwvU+eoSma/zcNdg6d4EhGgbUwnVJsFYl5QjHGt4DAoGgp2SDgu8Nz/Y3ryZ1+jR432RA5gwjYAQxPsvzFeRdPd3SbAnjTgnBAi/1KQCIqt82mBwzaXCAnFnI8RE7Na5xnRB7nUeGUqUrVw74SahbewvDpaAtukFYbd3Ll0Ge2XU7NHX8D80Rog+6Y1O11uQSoWZadmJv1OFbekDsseHh9sDMe/+NgFLkAhJePuUJv9YOH/02SvePtCl1yvQ2S2+4PLxQwkGffQcqiJiR2ag/zN8wpMeivlALIDdr0SLw== jedi132000@gmail.com"
}

variable "vpc_cidr" {}
variable "environment" {}
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "instance_type" {}
variable "ecs_aws_ami" {}

variable "private_subnet_cidrs" {
  type = "list"
}

variable "public_subnet_cidrs" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

output "default_alb_target_group" {
  value = "${module.ecs.default_alb_target_group}"
}
