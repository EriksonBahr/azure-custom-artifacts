$ErrorActionPreference = 'Stop'

#install the modules
Install-Module -Name SqlServerDsc -Force
Install-Module -Name StorageDsc -Force
Install-Module -Name xPSDesiredStateConfiguration -RequiredVersion 8.5.0.0 -Force

#common vars
$workDrive = 'D:'
$sqlServerIsoFile = 'en_sql_server_2016_developer_SP2.iso'
$sqlServerIsoPath = "$workDrive\$sqlServerIsoFile"
$mountedSQLServerPath = "$workDrive\SQL2016"

$username = "$env:USERDOMAIN\$env:USERNAME"
$password = ConvertTo-SecureString "MyP#!assword" -asPlainText -force
$creds = New-Object System.Management.Automation.PSCredential($username,$password)

$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
        }
    )
}

#compile the configurations
. ./ServerSQLServerConfig.ps1
InstallSQLServer -SourceInstallPath "yourURIHere" -SQLDestinationPath $sqlServerIsoPath -SQLFilesPath $mountedSQLServerPath

Start-DscConfiguration .\InstallSQLServer -wait -verbose -force