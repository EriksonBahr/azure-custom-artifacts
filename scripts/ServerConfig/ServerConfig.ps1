Configuration Apps
{
   Import-DscResource -Module cChoco -ModuleVersion 2.4.0.0
   Node 'localhost'
   {
      LocalConfigurationManager
      {
          DebugMode = 'ForceModuleImport'
      }
      cChocoInstaller installChoco
      {
        InstallDir = "C:\ProgramData\chocolatey\bin\"
      }
      cChocoPackageInstallerSet installApps
      {
         Ensure = 'Present'
         Name = @(
			"7zip"
         "notepadplusplus"
         "nssm"
		)
         DependsOn = "[cChocoInstaller]installChoco"
      }
    }
}
Apps