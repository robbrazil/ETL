# ETL
test project for ETL task

I have created the required resourtces on TErraform according to specifications and went a bit further:

Created a TFstate bucket that can be configure in the backend folder to allow for multi-region tfstate saved remotely

Created a tfvars that can be expanded for as many enbvironments as needed. (For this demo I have created only the dev.tfvars)

All objects can be reused (they are modules)

How to run this project:

1. clone the repo
2. run terraform init passing the backend file as a parameter
example : terraform init -backed-config=../backend/dev.tfbackend
   
4. Run terraform plan, passing the paramenter for tfvars
example: terraform plan -var-file=../tfvars.dev.tfvars



