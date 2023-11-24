# Web Tier using AWS EC2 Linux (without  multi-az/auto scaling)

Deploying a Linux Server EC2 Instance in AWS using Terraform

We have created 2 terraform modules.

1. vpc - to create vpc, public subnet, internet gateway, security groups and route tables
2. web - to create Linux Web EC2 instance with userdata script to display instance metadata using latest Amazon Linux ami.
3. main - These modules get called in main config.

Terraform Plan Output:
```
Plan: 7 to add, 0 to change, 0 to destroy.
```

Terraform Apply Output:
```
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

instance_id = "i-0af8e5b2d89a1e410"
public_ip = "http://44.211.171.94/"
```

Running Website:

![Alt text](/images/website.png)

Console:
![Alt text](/images/console.png)

Terraform Destroy Output:
```
Plan: 0 to add, 0 to change, 7 to destroy.

Destroy complete! Resources: 7 destroyed.
```