# Create a new load balancer

 provider "aws" {
          region = "ap-southeast-1"
 }

 resource "aws_instance" "test-elb01" {
          
   	  ami             = "ami-10acfb73"

          instance_type   = "t2.small"

          key_name        = "julo-ssh-singapore-dev"

          security_groups = ["sg-1438d872","sg-e0382187","sg-3ef31d58","sg-801c18e7","sg-a0c2b8c6"]

          subnet_id       = "subnet-14cc9762"
 
	  count           = "2" 

 tags {
          Name = "test-elb-${count.index}"
      }
 }

 resource "aws_elb" "bar" {
          name               = "foobar-terraform-elb"
          security_groups    = ["sg-1438d872","sg-e0382187","sg-3ef31d58","sg-801c18e7"]
          subnets            =  ["subnet-14cc9762"]

  listener    {
    instance_port       = 80
    instance_protocol   = "http"
    lb_port             = 80
    lb_protocol         = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${aws_instance.test-elb01.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 600
  connection_draining         = true
  connection_draining_timeout = 400

 tags {
          Name = "foobar-terraform-elb"
      }
 } 
