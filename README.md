# IAC-Terraform-Repo

## Using Terraform to set up baston connection 



###  Download the key from parameter store u can use thise command 

```bash
ssm get-parameter --name "IAC_TERRAFORM_REPO-ssm-kp" --output text --query  Parameter.Value > "parafile"
```

### To run this code you should use 

```hcl
terraform init 
terraform plan 
terraform apply --auto-approve 
```