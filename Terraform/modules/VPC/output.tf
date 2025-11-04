output "subnet_ids" {
  value = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
}

output "public_subnet_ids" {
  value = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id ]
}

output "sg_id" {
  value = [aws_security_group.ecs-cluster-sg.id]
}

output "alb_sg_id" {
  value = [aws_security_group.alb_sg.id]
}

output "vpc_id" {
    value = aws_vpc.ecs-vpc.id
  
}