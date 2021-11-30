variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "key" {
  type = string
  default = "sdkim1-key"
}

variable "name" {
  type = string
  default = "sdkim"
}

variable "ava_zone" {
  type = list
  default = ["a","c"]
}

variable "cidr_main" {
  type = string
  default = "10.0.0.0/16"
}

variable "pub_sub" {
  type = list
  default = ["10.0.0.0/24","10.0.1.0/24"]
}

variable "pri_sub" {
  type = list
  default = ["10.0.2.0/24","10.0.3.0/24"]
}

variable "pri_subdb" {
  type = list
  default = ["10.0.4.0/24","10.0.5.0/24"]
}

variable "cidr_route" {
  type = string
  default = "0.0.0.0/0"
}

variable "cidr_routev6" {
  type = string
  default = "::/0"
}


variable "ssh" {
  type = string
  default = "ssh"
}

variable "http" {
  type = string
  default = "http"
}

variable "icmp" {
  type = string
  default = "icmp"
}

variable "mysql" {
  type = string
  default = "mysql"
}

variable "port_ssh" {
  type = number
  default = 22
}

variable "port_http" {
  type = number
  default = 80
}

variable "port_mysql" {
  type = number
  default = 3306
}

variable "port_zero" {
  type = number
  default = 0
}

variable "port_minus" {
  type = number
  default = -1
}

variable "pro_icmp" {
  type = string
  default = "icmp"
}
variable "pro_tcp" {
  type = string
  default = "tcp"
}

variable "pro_udp" {
  type = string
  default = "udp"
}

variable "ins_type" {
  type = string
  default = "t2.micro"
}

variable "pri_ip" {
  type = string
  default = "10.0.0.11"
}

variable "nu" {
  default = null
}

variable "pro_HTTP" {
  type = string
  default = "HTTP"
}

variable "lb_type" {
  type = string
  default = "application"
}

variable "db_name" {
  type = string
  default = "mydb"
}

variable "db_username" {
  type = string
  default = "admin"
}

variable "db_pw" {
  type = string
  default = "It12345!"
}

variable "db_strg" {
  type = string
  default = "gp2"
}

variable "db_e_v" {
  type = string
  default = "8.0"
}
variable "ins_type_db" {
  type = string
  default = "db.t2.micro"
}