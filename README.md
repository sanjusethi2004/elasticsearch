# elasticsearch

Description:
This project is use to demonstrate to create a three node elastic search Cluster. 
For the project I have used terraform as IAS and Ansible for configuration. I have tried to automate complete cluster creation without a breakage in the process. So for this I have used dynamic inventory for Ansible.
For this I have spend 10 hour with multiple breakage as per my convenience. SSL part was little tricky as I wanted to automate that part as well.
Please follow below steps to create a cluster:
Create a key in AWS and update in terraform variable. 
	1. terraform init
         2. terraform plan
         3. terraform apply
