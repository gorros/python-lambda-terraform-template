# Here we define global values for variable which do not depend on development environment.

# project_name = "your_project_name"
# TODO: make sure to set right value for region
# region = us-east-1
vpc_cidr = {
  "dev"   = "172.28.0.0/16"
  "stage" = "172.27.0.0/16"
  "prod"  = "172.26.0.0/16"
}
