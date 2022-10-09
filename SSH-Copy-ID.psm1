function ssh-copy-id
{
<#
.SYNOPSIS
    Appends a public key to a machines ~/.ssh/authorized_keys file.
    CAUTION: This script is not declarative, it will append key(s) into authorized_keys that already exist.

.DESCRIPTION
    ssh-copy-id is a PowerShell script that uses ssh to log into a remote machine and append the
    indicated identity file to that machine's ~/.ssh/authorized_keys file. By default, it installs the key(s) stored in "$env:USERPROFILE\.ssh\id_rsa.pub".
    CAUTION: This script is not declarative, it will append key(s) into authorized_keys that already exist. 

.PARAMETER RemoteHost
    Specifies the IP or DNS name of the machine to install the public key on.

.PARAMETER RemoteUser
    Specifies which user's authorized_keys file that the key will be installed under.
    
.PARAMETER KeyFile
    A path of the keyfile to be installed.

.PARAMETER RemotePort
    SSH will attempt to connect to this port on the remote host. Defaults to 22

.INPUTS

    None at the moment.

.OUTPUTS

    None at the moment.

.EXAMPLE

    PS> ssh-copy-id root@172.16.1.10

.EXAMPLE

    PS> ssh-copy-id 172.16.1.10 -l root

.EXAMPLE

    PS> ssh-copy-id 172.16.1.10 -p 2222

.EXAMPLE

    PS> ssh-copy-id root@172.16.1.10 -i C:\users\n8tg\SpecialKeyDir\key.pub

.EXAMPLE

    PS> ssh-copy-id -RemoteHost 172.16.1.10 -RemoteUser root

.EXAMPLE

    PS> ssh-copy-id -RemoteHost 172.16.1.10 -RemoteUser root -KeyFile C:\users\n8tg\SpecialKeyDir\key.pub

.NOTES

    If no username is supplied using -RemoteUser or the User@RemoteHost syntax, the user running the command's username will be used.  

.LINK

https://github.com/n8tg/ssh-copy-id
#>


    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$false)]
        [string]
        $RemoteHost,

        [Alias('l')]
        [string]
        $RemoteUser,

        [Alias('p')]
        [string]
        $RemotePort = 22,

        [Alias('i')]
        [string]
        $KeyFile = "$env:USERPROFILE\.ssh\id_rsa.pub"
    )  

    PROCESS {

        if($RemoteHost -contains "@"){
            $RemoteUser = $RemoteHost.Split("@")[0]
            $RemoteHost = $RemoteHost.Split("@")[1]
        }

        # Check key file is there
        if(!(Test-Path $KeyFile)) { Write-Warning "Specified key file not found"; return }
        
        try{
            if($RemoteUser){
                Get-Content $KeyFile | ssh $RemoteHost -p $RemotePort -l $RemoteUser "cd; umask 077; mkdir -p `".ssh/`" && { [ -z \`tail -1c .ssh/authorized_keys 2>/dev/null\` ] || echo >> .ssh/authorized_keys; } && cat >> .ssh/authorized_keys || exit 1; "
            }else{
                Get-Content $KeyFile | ssh $RemoteHost -p $RemotePort "cd; umask 077; mkdir -p `".ssh/`" && { [ -z \`tail -1c .ssh/authorized_keys 2>/dev/null\` ] || echo >> .ssh/authorized_keys; } && cat >> .ssh/authorized_keys || exit 1; "
            }
        } catch {
            Write-Warning "An error occurred when installing the key"
            Write-Host $_
        }
    }
}

Export-ModuleMember -Function ssh-copy-id