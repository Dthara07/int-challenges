#!/bin/bash
terraform init $1
terraform get $1
terraform destroy -auto-approve $1 
