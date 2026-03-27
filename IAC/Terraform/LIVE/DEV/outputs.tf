output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "debug_account_id" {
  value = data.aws_caller_identity.current.account_id
}