# Copy dependencies from src to layers/nodejs for AWS layers
mkdir -p layers/nodejs && cp -r src/node_modules layers/nodejs
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_REGION=""
terraform init
terraform plan
terraform apply -auto-approve
#terraform destroy -auto-approve