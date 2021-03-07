output "created_iam_users_all" {
  value = aws_iam_user.users
}

output "created_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

output "created_iam_users_custom" {
  value = [
    for user in aws_iam_user.users :
    "User: ${user.name} has ARN: ${user.arn}"
  ]
}

output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.uniqe_id => user.id // "AIDA4BML45TW22K74HQFF" = "Vasya"
  }
}

// Print List of Users With Name 4 Characters Only
output "custom_if_length" {
  value = [
    for i in aws_iam_user.users :
    i.name
    if length(i.name) == 4
  ]
}


// Print Map of InstanceID: PublicIP
output "server_all" {
  value = {
    for server in aws_instance_servers :
    server.id => server.public_ip
  }
}
