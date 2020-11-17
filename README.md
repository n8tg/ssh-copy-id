# ssh-copy-id
This is a a lame PowerShell implementation of OpenSSH's ssh-copy-id

ssh-copy-id is a PowerShell script that uses ssh to log into a remote machine and append the
indicated identity file to that machine's `~/.ssh/authorized_keys` file. By default, it installs the key(s) stored in `$env:USERPROFILE\.ssh\id_rsa.pub`.  

CAUTION: This script is not declarative, it will append key(s) into authorized_keys that already exist. It may also be broken and overwrite your authorized_keys file. 


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

