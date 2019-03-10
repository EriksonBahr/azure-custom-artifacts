#install the modules
Install-Module -Name SystemLocaleDsc -Force
Install-Module -Name ComputerManagementDsc -Force
Install-Module -Name cChoco -Force
Install-Module -Name NetworkingDsc -Force

#compile the configurations
. ./CommonConfig.ps1

#start ensuring state - one by one
Start-DscConfiguration .\CommonFeatures -wait -verbose
Set-DscLocalConfigurationManager .\Reboot -verbose
Start-DscConfiguration .\Locale -wait -verbose
Start-DscConfiguration .\TimeZone -wait -verbose
Start-DscConfiguration .\CommonApps -wait -verbose
Start-DscConfiguration .\CommonFirewall -wait -verbose