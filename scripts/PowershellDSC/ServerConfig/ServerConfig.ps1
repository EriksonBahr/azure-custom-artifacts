Configuration ServerApps
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
        InstallDir = 'C:\ProgramData\chocolatey\bin\'
      }
      cChocoPackageInstallerSet installApps
      {
         Ensure = 'Present'
         Name = @(
			'7zip'
         'notepadplusplus'
         'nssm'
		)
         DependsOn = '[cChocoInstaller]installChoco'
      }
    }
}
ServerApps

Configuration ServerFeatures
{
   Node 'localhost'
   {
      WindowsFeature HyperV
      {
         Ensure = 'Present'
         Name = 'Hyper-V'
      }

      WindowsFeature Containers
      {
         Ensure = 'Present'
         Name = 'Containers'
         DependsOn = '[WindowsFeature]HyperV'
      }
   }
}
ServerFeatures

Configuration ServerFirewall
{
    Import-DscResource -Module NetworkingDsc
    node 'localhost'
    {
        Firewall AllowDatacenterConnection
        {
            Name                  = 'Datacenter'
            DisplayName           = 'Datacenter'
            Ensure                = 'Present'
            Enabled               = 'True'
            Profile               = 'Private'
            Direction             = 'Inbound'
            LocalPort             = '9000-9100'
            Protocol              = 'TCP'
            Description           = 'Firewall rule for Datacenter'
        }
    }
}
ServerFirewall