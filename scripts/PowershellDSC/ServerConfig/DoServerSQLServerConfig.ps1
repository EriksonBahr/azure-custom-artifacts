#install the modules
Install-Module -Name SqlServerDsc -Force
Install-Module -Name StorageDsc -Force
Install-Module -Name xPSDesiredStateConfiguration -RequiredVersion 8.5.0.0 -Force

#common vars
$workDrive = 'D:'
$sqlServerIsoFile = 'en_sql_server_2016_developer_SP2.iso'
$sqlServerIsoPath = "$workDrive\$sqlServerIsoFile"
$mountedSQLServerPath = "$workDrive\SQL2016"

#compile the configurations
. ./ServerSQLServerConfig.ps1
InstallSQLServer -SourceInstallPath "yourURIHere" -SQLDestinationPath $sqlServerIsoPath -SQLFilesPath $mountedSQLServerPath

Start-DscConfiguration .\InstallSQLServer -wait -verbose -force