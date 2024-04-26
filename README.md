# Terraform Configuration for AWS EC2 Instance

This Terraform configuration sets up an AWS EC2 instance with an Apache server, leveraging various Terraform provisioners and data sources to customize and manage the infrastructure.

## Overview

This project uses Terraform to automate the creation of an AWS EC2 instance and configure it to run an Apache web server. It includes:

- **Data Sources**: To dynamically fetch AMI IDs and VPC settings.
- **User Data**: To bootstrap the Apache server on instance initialization using `userdata.yaml`.
- **Provisioners**: For post-creation configuration and setup.

## Files

- `main.tf` - Contains the main Terraform configuration.
- `variables.tf` - Defines variables used across the configuration.
- `userdata.yaml` - User data script to install and start Apache server.
- `outputs.tf` - Defines output variables.

## Features

### Data Source Usage

Data sources are utilized to pass values dynamically to the instance resource attributes like AMI and the security group attribute `vpc_id`. This approach ensures that the instance uses the most appropriate and current settings without hardcoding values.

### User Data

The `userdata.yaml` file contains a script that automates the installation and setup of the Apache server on the EC2 instance. This ensures the web server is running immediately after the instance is launched.

### File Provisioner

The file provisioner is used to store static content on the created EC2 instance. In this configuration:

- **Content**: The text "mars" is stored.
- **Destination**: `barsoon.txt` on the EC2 instance.

### Remote-exec Provisioner

Optionally, the `remote-exec` provisioner can be used to execute commands on the remote instance after it's created. In this setup, it's configured to:

- Output the private IP address of the EC2 instance into a file stored remotely on the instance.

## Usage

1. **Initialize Terraform**:
terraform init

2. **Plan the deployment**:
terraform plan

3. **Apply the configuration**:
terraform apply


## Requirements

- AWS Account
- Terraform installed
- Appropriate AWS permissions set up for Terraform

Ensure you have configured your AWS credentials properly or use an IAM role with the necessary permissions.
