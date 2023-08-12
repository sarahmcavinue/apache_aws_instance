# provisioners
includes: provisioners:


Data source used passing values to the attributes; when creating the instance resource ami and the resource security group attribute vpc_id.
The data source uses the userdata.yaml template to run Apache server running on the instance created this allows for apache server to be bootstarpped to the instance using the userdata.yaml file. 
Provisioner file used to store the content "mars" to the destination file barsoon.txt that is stored on the ec2 instance that is creted by the terraform configuration.
Option to use remote-exec provisioner that serves to output the private IP address of the ec2-instance into a file stored remotely on the ec2 instance.

