resource "aws_vpc" "ecs-vpc" {
    cidr_block       = "10.0.0.0/16"

    tags = {
        Name = "name-ecs-vpc"
    }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.ecs-vpc.id
  availability_zone = "eu-west-2a"
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "name-public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.ecs-vpc.id
  availability_zone = "eu-west-2b"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "name-public-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.ecs-vpc.id
  availability_zone = "eu-west-2a"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "name-private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.ecs-vpc.id
  availability_zone = "eu-west-2b"
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "name-private-subnet-2"
  }
}

resource "aws_internet_gateway" "ecs-igw" {
  vpc_id = aws_vpc.ecs-vpc.id

  tags = {
    Name = "ame-ecs-igw"
  }
}

resource "aws_eip" "elastic-ip" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.ecs-igw]
}

resource "aws_nat_gateway" "ecs-ngw" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "name-ecs-ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.ecs-igw]
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.ecs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs-igw.id
  }

  tags = {
    Name = "name-public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.ecs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ecs-ngw.id
  }

  tags = {
    Name = "name-private-rt"
  }

  depends_on = [ aws_nat_gateway.ecs-ngw ]
}
resource "aws_route_table_association" "public-rt-assoc" {
  for_each       = {
    subnet1 = aws_subnet.public-subnet-1.id
    subnet2 = aws_subnet.public-subnet-2.id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.public-rt.id
}
# note only one private subnet is currently used
resource "aws_route_table_association" "private-rt-assoc" {
    subnet_id = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-rt-assoc-2" {
    subnet_id      = aws_subnet.private-subnet-2.id
    route_table_id = aws_route_table.private-rt.id
}

# Security groups
# ALB security group
resource "aws_security_group" "alb_sg" {
  name        = "ec2-sg"
  description = "application load balancer security group"
  vpc_id = aws_vpc.ecs-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound to anywhere (default)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs-cluster-sg" {
  name        = "ecs-sg"
  description = "ecs cluster security group"
  vpc_id = aws_vpc.ecs-vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound to anywhere (default)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}