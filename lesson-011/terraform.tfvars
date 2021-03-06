# Auto Fill variables for Dev

#File names can be  as:
# terraform.tfvars
# prod.auto.tfvars
# dev.auto.tfvars


region                     = "ca-central-1"
instance_type              = "t2.small"
enable_detailed_monitoring = false

allow_ports = ["80", "443"]

common_tags = {
  Owner       = "Sedrak Khachatryan"
  Project     = "Phoenix"
  CostCenter  = "123477"
  Environment = "dev"
}
