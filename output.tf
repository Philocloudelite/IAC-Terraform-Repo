output "public_ip" {
  description = "public ip"
  value       = aws_instance.web.public_ip
  sensitive   = false
}
