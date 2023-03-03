locals {
  vpc_tags = {
    Name = "vpc-${var.env}-vpc"
    ENV  = var.env
    PROJECT = "roboshop"
  }
}