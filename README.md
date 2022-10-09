# ssh-copy-id

This is a a lame PowerShell implementation of OpenSSH's ssh-copy-id

ssh-copy-id is a PowerShell script that uses ssh to log into a remote machine and append the
indicated identity file to that machine's `~/.ssh/authorized_keys` file. By default, it installs the key(s) stored in `$env:USERPROFILE\.ssh\id_rsa.pub`.

CAUTION: This script is not declarative, it will append key(s) into authorized_keys that already exist. It may also be broken and overwrite your authorized_keys file.

---

## Installation

This is published as a module in the PowerShell Gallery.

### Installing SSH-Copy-ID the easy way

    Install-Module -Name SSH-Copy-ID

### Installing SSH-Copy-ID the hard way

Copy the SSH-Copy-ID folder to any one of the module folders that's returned by `$Env:PSModulePath`. Then import SSH-Copy-ID into your PowerShell session. This may be necessary if you can't install the module using the PowerShell Gallery. 

    PS> $Env:PSModulePath
    C:\Users\n8tg\OneDrive\OneDrive Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

    PS> Copy-Item -Path ".\SSH-Copy-ID\" -Destination "C:\Users\n8tg\OneDrive\OneDrive Documents\WindowsPowerShell\Modules" -Recurse

    PS> Import-Module SSH-Copy-ID

### Getting access to the PowerShell Gallery

See: <https://docs.microsoft.com/en-us/powershell/scripting/gallery/overview?view=powershell-7.1>

    Install-PackageProvider -Name NuGet -Force
    Install-Module -Name PowerShellGet -Force

---

## Usage

### Parameters (PS Style)

Param | Mandatory | Default | Description
------|-----------|---------|------------
RemoteHost | Yes | (none) | Specifies the IP or DNS name of the machine to install the public key on.
RemoteUser | No |(none) | Specifies which user's authorized_keys file that the key will be installed under.
KeyFile | No | "$env:USERPROFILE\.ssh\id_rsa.pub" | A path of the keyfile to be installed.
RemotePort | No | 22 | SSH will attempt to connect to this port on the remote host.

### Parameters (Unix Style)

Param | Mandatory | Default | Description
------|-----------|---------|------------
$RemoteHost (Positional Parameter) | Yes | (none) | Specifies the IP or DNS name of the machine to install the public key on. Used without referencing a parameter flag.
-l | No |(none) | Specifies which user's authorized_keys file that the key will be installed under.
-i | No | "$env:USERPROFILE\.ssh\id_rsa.pub" | A path of the keyfile to be installed.
-p | No | 22 | SSH will attempt to connect to this port on the remote host.

---

## Examples

### Unix username style

    ssh-copy-id root@172.16.1.10 
    ssh-copy-id 172.16.1.10 -l root 

### Unix username style with a specified key file

    ssh-copy-id root@172.16.1.10 -i C:\users\n8tg\SpecialKeyDir\key.pub

### PowerShell parameter style with a username

    ssh-copy-id -RemoteHost 172.16.1.10 -RemoteUser root  

### PowerShell parameter style with a username and a specific key

    ssh-copy-id -RemoteHost 172.16.1.10 -RemoteUser root -KeyFile C:\users\n8tg\SpecialKeyDir\key.pub

### You can mix and match if you choose

    ssh-copy-id -RemoteHost root@172.16.1.10 -i c:\why\key.pub
