# README:
# This utility is run before `kitchen create` on AWS instance.  It populates .kitchen.local.yml with the 
# subnet_id and security_group_id of the instance where this utility runs.
#
# Need some checking like this (taken from AWS EC2 tool)
#
#x=$(curl -s http://169.254.169.254/)
#if ( $? -gt 0 ) {
#        Write-Host '[ERROR] Command not valid outside EC2 instance. Please run this command within a running EC2 instance.'
#        exit 1
#}

$mymac = (Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/mac -UseBasicParsing).Content
$mysg = (Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/network/interfaces/macs/$mymac/security-group-ids -UseBasicParsing).Content
$mysubnet = (Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/network/interfaces/macs/$mymac/subnet-id -UseBasicParsing).Content

Write-Host "writing to .kitchen.local.yml with security group $mysg on subnet $mysubnet"

$entries = "
---
driver:
    security_group_ids: $mysg
    subnet_id: $mysubnet
"
Set-Content -Path .\\kitchen.local.yml $entries
