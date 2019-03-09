#install the modules
Install-Module -Name cChoco -Force

#compile the configurations
. ./ServerConfig.ps1

#start ensuring state - one by one
Start-DscConfiguration .\Apps -wait -verbose