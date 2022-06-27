#!/bin/bash

terraform init $1
terraform get $1
terraform plan $1
