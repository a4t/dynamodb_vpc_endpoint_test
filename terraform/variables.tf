variable "vpc_cidr_number" {
  default = 1
}

variable "env" {
  type = string
}

variable "availability_zone" {
  default = "ap-northeast-1a"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
