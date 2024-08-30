

# ec2.tf
resource "aws_instance" "public_instance" {
  for_each = var.instances_config

  ami           = var.instance_image  
  instance_type = var.instance_type
  

  associate_public_ip_address = var.enable_public_ip
  
  subnet_id     = var.public_subnet_ids[0]
  

  vpc_security_group_ids = [aws_security_group.public_sg.id]


  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags.Project}-${var.common_tags.Environment}-${each.value.name}"
    }
  )

  
  
  iam_instance_profile = var.aws_iam_instance_profile
}

resource "aws_instance" "private_instance" {
  ami           = var.instance_image  
  instance_type = var.instance_type

  subnet_id     = var.private_subnet_ids[0]
  

  vpc_security_group_ids = [aws_security_group.private_sg.id] 

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-${var.environment}-private-ec2"
    }
  )

}

# ssm_role
resource "aws_iam_role" "ssm_role" {
  name = "${var.project}-${var.environment}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid = ""
      },
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-${var.environment}-ssm-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_cw_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.project}-${var.environment}-ssm-instance-profile"
  role = aws_iam_role.ssm_role.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-${var.environment}-ssm-instance-profile"
    }
  )
}

# security_group
resource "aws_security_group" "public_sg" {
  name        = "${var.project}-${var.environment}-public-sg"
  description = "Security group for public instances"
  
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}

resource "aws_security_group" "private_sg" {
  name        = "${var.project}-${var.environment}-private-sg"
  description = "Security group for private instances"
  

  vpc_id      = var.vpc_id

  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}
