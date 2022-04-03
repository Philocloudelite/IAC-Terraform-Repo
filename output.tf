# # Fetching Just One pub ip in the list
# output "public_ip" {
#   description = "public ip"
#   value       = aws_instance.web[0].public_ip 
#   sensitive   = false
# }

# # fetching all of the public_ip in the list
# output "public_ip2" {
#   description = "public ip2"
#   value       = [aws_instance.web[*].public_ip]
#   sensitive   = false
# }

# # what if we want just two of the pub ip in the list
# output "public_ip3" {
#   description = "public ip3"
#   value       = slice(aws_instance.web[*].public_ip,0, )
#   sensitive   = false
# }

# # For loop with output 

# output "ec2_arn" {
#   description = "ec2 arn's"
#   value       = [for arn in aws_instance.web: arn.arn]
#   sensitive   = false
# }
