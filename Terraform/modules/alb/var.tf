variable "alb_name" {
  default = "ec2-sg"
}

variable "tg_name" {
  default = "tf-example-lb-tg"

}

variable "vpc_id" {
    type = string
  
}

variable "sg_id" {
  
}

variable "subnet_ids" {
  type = list(string)
}