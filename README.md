# Challenge-1 : 3-Tier Environment

This challenge is to create a 3-tier env using a tool of my choice.

- Provider : GCP
- Tool: Terraform

### Resources Created

- Custom VPC
- 2 Private subnets each for web-tier and app-tier
- 1 Subnet for internal lb proxy
- External lb (forwarding rules, proxy. URLmap, backend services, health check)
- Managed regional instance groups for both web-tier and app-tier
- Firewall rules
- Web GCE instances in private subnet-1 (vm instances created per available zone)
- App GCE instances in private subnet-2 (vm instances created per available zone)
- Cloud SQL (Used Peering to connect services within cluster)
- Cloud Nat and Router for private instance access to internet
- Script to run Nginx server. Displays the instance name from metadata.
- Armor security policy

# Challenge-2 : AWS Metadata

Query the meta data of an instance within aws and provide a json formatted output

Tool used : Shell scripting

- Example-1:
  $ ./matadata.sh

Output:
`{ "accountId": "649111442550", "architecture": "x86_64", "availabilityZone": "eu-west-2b", "billingProducts": null, "devpayProductCodes": null, "marketplaceProductCodes": null, "imageId": "ami-0fb391cce7a602d1f", "instanceId": "i-0ee35c7b380f472de", "instanceType": "t2.micro", "kernelId": null, "pendingTime": "2022-06-24T06:53:00Z", "privateIp": "172.31.37.173", "ramdiskId": null, "region": "eu-west-2", "version": "2017-09-30" }`

- Example-2:
  $ ./matadata.sh availabilityZone region

Output:
`eu-west-2b`
`eu-west-2`

# Challenge-3 : Parse nested object

A function that you pass in the object and a key and get back the value

Run : `node nestedObjParser.js`

Object : { x: { y: { z: 'a' } } }

- Key : x/y/z
  `output: a`

- Key : x/y or x/y/
  `output: { z: 'a' }`

- Key : x
  `output: { y: { z: 'a' } }`

- Key : '' (Empty or invalid key returns the same object back)
  `output: { x: { y: { z: 'a' } } }`
