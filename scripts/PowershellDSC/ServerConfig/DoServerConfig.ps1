#install the modules
Install-Module -Name cChoco -Force
Install-Module -Name NetworkingDsc -Force

#compile the configurations
. ./ServerConfig.ps1

#start ensuring state - one by one
Start-DscConfiguration .\ServerApps -wait -verbose
Start-DscConfiguration .\ServerFeatures -wait -verbose
Start-DscConfiguration .\ServerFirewall -wait -verbose