# Copy dependencies from src to layers/nodejs for AWS layers
mkdir -p layers/nodejs && cp -r src/node_modules layers/nodejs
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_REGION=""
terraform init
terraform plan
terraform apply -auto-approve
# terraform destroy -auto-approve
# deleting an event source mapping manually if not deleted by terraform destroy, run this command in AWS shell.
# aws lambda delete-event-source-mapping --uuid {event-source-mapping-id} --region {aws-region}
