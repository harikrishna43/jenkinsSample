		Param (
			
		     
			 $configuration = "Debug",
			 [string] $packageversion = "0.0.0.0"
			
		)
		$nugetdir = "..\packages\nuget"

		$wwwRoot = "C:\inetpub\wwwroot\transgird.Corpotate\"

		&$nugetdir\nuget.exe restore ..\TransgridCorpotate.sln

		# Identify latest version for MSBuild tool
		$path = ..\packages\vswhere.2.7.1\tools\vswhere.exe -latest -prerelease -products * -requires Microsoft.Component.MSBuild -property installationPath


		if ($path) {
		$msbuild = join-path $path 'MSBuild\Current\Bin\MSBuild.exe'
			if (-not (test-path $msbuild)) {
			$msbuild = join-path $path 'MSBuild\Current\Bin\MSBuild.exe'
			if (-not (test-path $msbuild)) {
				throw 'Failed to find MSBuild'
			}
		}  
		
		# Rebuild the solution
		 &$msbuild ..\TransgridCorpotate.sln /t:Rebuild /p:Configuration=$configuration /p:PackageVersion=$packageversion
		
		 # Generates the code package $wwwRoot
		 &$msbuild ..\TransgridCorpotate.sln /target:Build /toolsversion:Current /nologo /maxcpucount:1 /p:AutoParameterizationWebConfigConnectionStrings=False /p:Configuration=$configuration /p:DeployOnBuild=true /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=false /p:publishUrl=$wwwRoot /p:_FindDependencies=false
		}	
	
		
		# #Local IIS host
		# $SiteFolderPath = $wwwRoot              
		# $SiteAppPool = "Transgridwebsite"
		# $SiteName = "Transgridwebsite"
		# $SiteHostName = "Transgridwebsite.localhost"

		# Import-Module WebAdministration
		# Install-Module -Name 'Carbon' -AllowClobber
		# Import-Module 'Carbon'
		
		# if(Test-Path IIS:\AppPools\$SiteAppPool)
		# {
			# "AppPool is already there"
		# }
		# else
		# {
			# New-Item IIS:\AppPools\$SiteAppPool
		# }
		
		# if(Test-Path IIS:\Sites\$SiteName)
		# {
			# "SiteName is already there"
		# }
		# else
		# {	New-Item IIS:\Sites\$SiteName -physicalPath $SiteFolderPath -bindings @{protocol="http";bindingInformation=":80:"+$SiteHostName}
			# Set-ItemProperty IIS:\Sites\$SiteName -name applicationPool -value $SiteAppPool
			# #Set-HostsEntry -IPAddress 127.0.0.1 -HostName 'lumeawebsite.localhost' 
		# }
		
		# #Add / Edit host enry
		
		# Set-CHostsEntry -IPAddress 127.0.0.1 -HostName 'Transgridwebsite.localhost' 
		
		# #Complete	