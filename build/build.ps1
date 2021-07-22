Param (
   [Parameter(Mandatory = $true)]
   [string] $packageversion
)
$currentdir = $(get-location).Path
$nugetdir = ".\nuget"

$wwwRoot = $PSScriptRoot + "\_output\wwwroot"
$outputfolder = $PSScriptRoot + "\_output\"
$outputartifacts = $PSScriptRoot +  "\_output\artifacts"


&$nugetdir\nuget.exe restore JenkinsSample.sln

# Identify latest version for MSBuild tool
$path = .\vswhere\tools\vswhere.exe -latest -prerelease -products * -requires Microsoft.Component.MSBuild -property installationPath


if ($path) {
    $msbuild = join-path $path 'MSBuild\Current\Bin\MSBuild.exe'
			if (-not (test-path $msbuild)) {
			$msbuild = join-path $path 'MSBuild\Current\Bin\MSBuild.exe'
			if (-not (test-path $msbuild)) {
				throw 'Failed to find MSBuild'
			}
		}  

    
    if (test-path $outputfolder) {
        Remove-Item -path $outputfolder -recurse
    }

    # Rebuild the solution
    &$msbuild .\JenkinsSample.sln /t:Rebuild /p:Configuration=Release /p:PackageVersion=$packageversion
	
	 # Generates the code package $wwwRoot
    &$msbuild .\JenkinsSample.sln /target:Build /toolsversion:Current /nologo /maxcpucount:1 /p:Configuration=Release /p:DeployOnBuild=true /p:AutoParameterizationWebConfigConnectionStrings=False /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=false /p:publishUrl=$wwwroot /p:_FindDependencies=false
	
	# Generate nuget package
	# &$nugetdir\nuget.exe pack $PSScriptRoot\TransgridCorpotate.nuspec -Version $packageversion -Verbosity detailed -BasePath $wwwroot -OutputDirectory $outputartifacts
	}