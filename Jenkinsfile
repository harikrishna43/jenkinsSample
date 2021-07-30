//def ReleaseDir = "c:\inetpub\wwwroot"
pipeline {
			agent any
			stages {
				
				stage('Build') {
    					steps {
							bat ".\\nuget\\nuget.exe restore JenkinsSample.sln"
							bat "\"${tool 'MSBuild'}\" JenkinsSample.sln"
    					    bat "PowerShell.exe -ExecutionPolicy Bypass -File .\\build\\build.ps1 Release -verbose"
    					}
				}
			}
}
