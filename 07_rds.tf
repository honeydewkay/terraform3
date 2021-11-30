resource "aws_db_instance" "sdkim_mydb" {
  allocated_storage = 20
  storage_type = var.db_strg
  engine = var.mysql
  engine_version = var.db_e_v
  instance_class = var.ins_type_db
  name = var.db_name
  identifier = var.db_name
  username = var.db_username
  password = var.db_pw
  parameter_group_name = "default.mysql8.0"  #기존에 있던거
  availability_zone = "${var.region}${var.ava_zone[0]}"
  db_subnet_group_name = aws_db_subnet_group.sdkim_dbsg.id
  vpc_security_group_ids = [aws_security_group.sdkim_sg.id]
  skip_final_snapshot = true
  tags = {
    "Name" = "${var.name}-db"
  }
}

resource "aws_db_subnet_group" "sdkim_dbsg" {
  name = "${var.name}-dbsg"
  subnet_ids = [aws_subnet.sdkim_pridb[0].id,aws_subnet.sdkim_pridb[1].id]
}