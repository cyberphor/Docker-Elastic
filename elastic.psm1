function Get-Elasticsearch {
    $OutFile = "elasticsearch-8.6.2-windows-x86_64.zip"
    $Uri = "https://artifacts.elastic.co/downloads/elasticsearch/" + $OutFile
    Invoke-RestMethod -Uri $Uri -OutFile $OutFile    
}

function Install-Elasticsearch {
    Param([switch]$Force)
    $Path = "elasticsearch-8.6.2-windows-x86_64.zip"
    $DestinationPath = "C:\Program Files\Elastic\"
    $ConfigurationFile = "C:\Program Files\Elastic\elasticsearch-8.6.2\config\elasticsearch.yml"
    $ClusterName = "evil.corp"
    $NodeName = "node01"
    $BinDirectory = "C:\Program Files\Elastic\elasticsearch-8.6.2\bin\" 
    $BinFile = "elasticsearch-service.bat"
    if ((Test-Path -Path $DestinationPath) -or ($Force)) {
        try {
            Expand-Archive -Path $Path -DestinationPath $DestinationPath -ErrorAction Stop
            Remove-Item -Path $ConfigurationFile
            New-Item -Path $ConfigurationFile
            Add-Content -Value $("cluster.name: " + $ClusterName) -Path $ConfigurationFile
            Add-Content -Value $("node.name: " + $NodeName) -Path $ConfigurationFile
            Set-Location -Path $BinDirectory
            Start-Process -FilePath $BinFile -ArgumentList "install" -WindowStyle Hidden
            Set-Service -Name "elasticsearch-service-x64" -StartupType Manual
            Start-Service -Name "elasticsearch"
        } catch {
            Write-Host $_
        }
    }
}