//def ReleaseDir = "c:\inetpub\wwwroot"
pipeline {
			agent any
			stages {
				
				stage('Build') {
    					steps {
    					    bat "PowerShell.exe -ExecutionPolicy Bypass -File .\\build.ps1 Release -verbose	"
    					}
				}
			}
}
