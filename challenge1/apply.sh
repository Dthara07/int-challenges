#!/bin/bash

terraform init $1
terraform get $1
terraform apply -auto-approve $1 

