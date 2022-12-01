#export AWS_ACCESS_KEY_ID="AKIAQTHXZ25UNOJ4HOUY"
#export AWS_SECRET_ACCESS_KEY="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"
terraform init
terraform plan -out tfplan.out
terraform apply tfplan.out