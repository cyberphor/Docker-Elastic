function Clear-DockerContent {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
    docker system prune -af; 
    clear
}

function Set-VirtualMemorySize {
    bash -c "echo 'vm.max_map_count = 262144' | sudo tee /etc/sysctl.conf"
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
    $CaCertificateDirectory = "/opt/elasticsearch/config/certs/"
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
