Configuration DSCFeature
{
   Node 'localhost'
   {
      WindowsFeature DSC
      {
         Ensure = 'Present'
         Name = 'Dsc-Service'
      }
   }
}
DSCFeature

Configuration Reboot
{ 
    Node 'localhost'
    {
        LocalConfigurationManager
        {
            RebootNodeIfNeeded = $true
        }
    }
}
Reboot

Configuration Locale
{
   Import-DSCResource -ModuleName SystemLocaleDsc

   Node 'localhost'
   {
        SystemLocale LocaleenUS
        {
            IsSingleInstance = 'Yes'
            SystemLocale     = 'en-US'
        }
   }
}
Locale

Configuration TimeZone
{
    Import-DSCResource -ModuleName ComputerManagementDsc

    Node 'localhost'
    {
        TimeZone Brazil
        {
            IsSingleInstance = 'Yes'
            TimeZone         = 'E. South America Standard Time'
        }
    }
}
TimeZone

Configuration CommonApps
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
		)
         DependsOn = "[cChocoInstaller]installChoco"
      }
    }
}
CommonApps