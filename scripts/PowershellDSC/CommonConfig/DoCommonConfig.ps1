#install the modules
Install-Module -Name SystemLocaleDsc -Force
Install-Module -Name ComputerManagementDsc -Force
Install-Module -Name cChoco -Force
Install-Module -Name NetworkingDsc -Force

#compile the configurations
. ./CommonConfig.ps1

#start ensuring state - one by one
Start-DscConfiguration .\CommonFeatures -wait -verbose -force
Set-DscLocalConfigurationManager .\Reboot -verbose -force
Start-DscConfiguration .\Locale -wait -verbose -force
Start-DscConfiguration .\TimeZone -wait -verbose -force
Start-DscConfiguration .\CommonApps -wait -verbose -force
Start-DscConfiguration .\CommonFirewall -wait -verbose -force