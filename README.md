# ssh-copy-id
This is a a lame PowerShell implementation of OpenSSH's ssh-copy-id

ssh-copy-id is a PowerShell script that uses ssh to log into a remote machine and append the
indicated identity file to that machine's `~/.ssh/authorized_keys` file. By default, it installs the key(s) stored in `$env:USERPROFILE\.ssh\id_rsa.pub`.  

CAUTION: This script is not declarative, it will append key(s) into authorized_keys that already exist. It may also be broken and overwrite your authorized_keys file. 

## Installation
This is published as a module in the PowerShell Gallery. 

### Installing SSH-Copy-ID the easy way
    Install-Module -Name SSH-Copy-ID 

### Installing SSH-Copy-ID the hard way
Copy the SSH-Copy-ID folder to any one of the module folders that's returned by `$Env:PSModulePath`. Then import it into your PowerShell session. This may be necessary if you can't install the module using the PowerShell Gallery. 

    PS> $Env:PSModulePath
    C:\Users\n8tg\OneDrive\OneDrive Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

    PS> Copy-Item -Path ".\SSH-Copy-ID\" -Destination "C:\Users\n8tg\OneDrive\OneDrive Documents\WindowsPowerShell\Modules" -Recurse

### Getting access to the PowerShell Gallery
See: https://docs.microsoft.com/en-us/powershell/scripting/gallery/overview?view=powershell-7.1

    Install-PackageProvider -Name NuGet -Force
    Install-Module -Name PowerShellGet -Force


## Examples

### Unix username style
    ssh-copy-id root@172.16.1.10  

### Unix username style with a specified key file
    ssh-copy-id root@172.16.1.10 -l C:\users\n8tg\SpecialKeyDir\key.pub

### PowerShell parameter style with a username
    ssh-copy-id -RemoteHost 172.16.1.10 -RemoteUser root  

### PowerShell parameter style with a username and a specific key
    ssh-copy-id -RemoteHost 172.16.1.10 -RemoteUser root -KeyFile C:\users\n8tg\SpecialKeyDir\key.pub

### You can mix and match if you choose
    ssh-copy-id -RemoteHost root@172.16.1.10 -l c:\test\test

