Configuration InstallSQLServer
{
    param(
        $SourceInstallPath,
        $SQLDestinationPath,
        $SQLFilesPath,
        [PSCredential]
        $Creds
    )
     Import-DscResource -ModuleName SqlServerDsc
     Import-DscResource -ModuleName StorageDsc
     Import-DscResource -ModuleName xPSDesiredStateConfiguration -ModuleVersion 8.5.0.0

     node 'localhost'
     {
        WindowsFeature 'NetFramework45'
        {
            Name   = 'NET-Framework-45-Core'
            Ensure = 'Present'
        }

        xRemoteFile 'DownloadSQLServer'
        {       	     	          	
            Uri = $SourceInstallPath            	
            DestinationPath = $SQLDestinationPath            
        }

        MountImage 'SQLServer'
        {
            Ensure      = 'Present'
            ImagePath   = $SQLDestinationPath
            DriveLetter = 'S'
            DependsOn = '[xRemoteFile]DownloadSQLServer'
        }

        File 'CopyMountedFiles'
        {
            Ensure = 'Present'
            Type = 'Directory'
            Recurse = $true
            SourcePath = 'S:\'
            DestinationPath = $SQLFilesPath
            DependsOn = '[MountImage]SQLServer'
        }

        SqlSetup 'InstallDefaultInstance'
        {
            InstanceName        = 'MSSQLSERVER'
            Features            = 'SQLENGINE'
            UpdateEnabled       = 'False'
            SQLCollation        = 'SQL_Latin1_General_CP1_CI_AS'
            SecurityMode        = 'SQL' #mixed mode
            SAPwd               = $Creds
            SourcePath          = $SQLFilesPath
            SQLSysAdminAccounts = @('Administrators')
            DependsOn           = '[WindowsFeature]NetFramework45', '[File]CopyMountedFiles'
        }
     }
}