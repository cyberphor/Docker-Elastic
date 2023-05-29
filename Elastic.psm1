function Clear-DockerContent {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
    docker system prune -af; 
    Clear-Host
}

function Restart-WSL {
    Get-Service LxssManager | Restart-Service
}

function Set-WSLDistro {
    Param([string]$Distro = "docker-desktop")
    wsl --set-default $Distro
}

function Set-VirtualMemorySize {
    <#
    .LINK
    https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_set_vm_max_map_count_to_at_least_262144
    #>
    Write-Output "wsl -d docker-desktop -u root"
    Write-Output "sysctl -w vm.max_map_count=262144"
}

function Show-HostsFile {
    Get-Content "$env:windir\System32\drivers\etc\hosts"
}

function Test-Elasticsearch {
    <#
    .LINK
    https://www.phillipsj.net/posts/windows-curl-and-self-signed-certs/
    #>
    $Container = "elasticsearch"
    $CaCertificate = "ca.crt"
    $CaCertificateDirectory = "/usr/share/elasticsearch/config/certs/"
    $CaCertificatePath = $($CaCertificateDirectory + $CaCertificate)
    $HostsFile = "$env:windir\System32\drivers\etc\hosts"
    $Username = "elastic"
    $Password = "elastic"
    $Credentials = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$($Username):$($Password)"))
    $Headers = @{Authorization = "Basic $Credentials"}
    $Uri = "https://" + $Container + ":9200/_cat/health"
    $DNSEntry = "127.0.0.1`t$Container"
    docker cp $($Container + ":" + $CaCertificatePath) $CaCertificate
    Import-Certificate -FilePath $CaCertificate -CertStoreLocation Cert:\LocalMachine\Root | Out-Null
    if (-not (Select-String -Path $HostsFile -Pattern $DNSEntry)) {
        Add-Content -Path $HostsFile -Value $DNSEntry -Force
    } 
    Invoke-RestMethod -Uri $Uri -Headers $Headers
    Remove-Item $CaCertificate
}
