# Challenge-1 : 3-Tier Environment

This challenge is to create a 3-tier env using a tool of my choice.

- Provider : GCP
- Tool: Terraform

Have created below resources

- Custom VPC
- Private and public subnet
- Firewall rules
- Web tier in public subnet (vm instances created per available zone)
- App tier in private subnet (vm instances created per available zone)
- Cloud SQL (Used Peering to connect services within cluster)
- Cloud Nat and Router for private instance access to internet
- Script to run Apache server on web-tier. Displays the instance name from metadata.

# Challenge-2 :

Query the meta data of an instance within aws and provide a json formatted output

###Response without Arg:

- Example-1:
  $ ./query-matadata.sh

Output:
`{ "accountId": "649111442550", "architecture": "x86_64", "availabilityZone": "eu-west-2b", "billingProducts": null, "devpayProductCodes": null, "marketplaceProductCodes": null, "imageId": "ami-0fb391cce7a602d1f", "instanceId": "i-0ee35c7b380f472de", "instanceType": "t2.micro", "kernelId": null, "pendingTime": "2022-06-24T06:53:00Z", "privateIp": "172.31.37.173", "ramdiskId": null, "region": "eu-west-2", "version": "2017-09-30" }`

- Example-2:
  $ ./query-matadata.sh availabilityZone region

Output:
`{ "availabilityZone": "eu-west-2b" }`
`{ "region": "eu-west-2" }`
