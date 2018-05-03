function Invoke-RunAs {
<#
.DESCRIPTION
Runas knockoff. Will bypass GPO path restrictions.
.PARAMETER UserName
Provide a user
.PARAMETER Password
Provide a password
.PARAMETER Domain
Provide optional domain
.Example
Invoke-RunAs -username administrator -password "P@$$word!" -domain CORPA
#>
    [CmdletBinding()]Param (
    [Parameter(
        ValueFromPipeline=$True,
        Mandatory=$True)]
        [String]$username,
    [Parameter(
        ValueFromPipeline=$True,
        Mandatory=$True)]
        [String]$password,
    [Parameter(
        ValueFromPipeline=$True,
        Mandatory=$False)]
        [String]$domain,
    [Parameter(
        ValueFromPipeline=$True,
        Mandatory=$true)]
        [String]$cmd,
    [Parameter(
        ValueFromPipeline=$True,
        Mandatory=$False)]
        [String]$args
    )

	
$sec_password = convertto-securestring $password -asplaintext -force
$process = New-Object System.Diagnostics.Process;
$process.StartInfo.UserName = $username;
$process.StartInfo.Password = $sec_password;
$process.StartInfo.Domain = $domain;
$process.StartInfo.UseShellExecute = $false;
$process.StartInfo.RedirectStandardOutput = $true;
$process.StartInfo.CreateNoWindow = $true;
$process.StartInfo.FileName = "cmd.exe";
$process.StartInfo.Arguments = "/c " + $cmd;
Write-host $cmd
$process.Start();
$outputStream = $process.StandardOutput;
$outputStream.ReadToEnd();
    
}