# ---------------------------------------
# Define una instancia EC2 con AMI Ubuntu
# ---------------------------------------
resource "aws_instance" "mi_servidor_ec2" {
  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
#  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  network_interface {
    network_interface_id = aws_network_interface.main_ni.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Informacion de Inicializacion - ICESI!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Environment = "Lab"
    Name        = "mi_servidor_ec2"
  }
}