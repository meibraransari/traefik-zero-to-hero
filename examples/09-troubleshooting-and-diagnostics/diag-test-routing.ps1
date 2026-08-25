param(
    [string]$ServerIp = "127.0.0.1",
    [string]$Domain = "whoami.example.com"
)

Write-Host "Testing HTTP route: http://$Domain -> $ServerIp:80"
Invoke-RestMethod -Uri "http://$ServerIp" -Headers @{ Host = $Domain } -Method Get

Write-Host "Testing Traefik API Routers: http://$ServerIp:8080/api/http/routers"
try {
    $routers = Invoke-RestMethod -Uri "http://${ServerIp}:8080/api/http/routers"
    $routers | Select-Object name, status, rule | Format-Table -AutoSize
} catch {
    Write-Warning "Could not connect to Traefik API on port 8080."
}
