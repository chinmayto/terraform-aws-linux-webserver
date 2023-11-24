# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Create the Linux EC2 Web server
resource "aws_instance" "web" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = var.subnet_id
  security_groups = var.security_groups


  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install -y httpd.x86_64
  systemctl start httpd.service
  systemctl enable httpd.service
  instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
  pubHostName=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
  pubIPv4=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
  instanceAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
  echo "<center><h1>AWS Linux VM Deployed with Terraform</h1></center>" > /var/www/html/index.html
  echo "<center> Instance ID: $instanceId </center>" >> /var/www/html/index.html
  echo "<center> Public Hostname: $pubHostName </center>" >> /var/www/html/index.html
  echo "<center> Public IPv4: $pubIPv4 </center>" >> /var/www/html/index.html
  echo "<center> AWS Availablity Zone: $instanceAZ </center>" >> /var/www/html/index.html
  EOF

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2"
  })
}