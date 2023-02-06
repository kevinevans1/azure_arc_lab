## Chocko Install
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

## Web Browser Install
choco install microsoft-edge -y

## Azure Storage Explorer
choco install microsoftazurestorageexplorer -y