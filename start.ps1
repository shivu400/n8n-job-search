# PowerShell 1-Click Launcher for Nagendra's n8n Automation
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "   🚀 Nagendra M.P - Safe Job Automation (n8n + Gemini)" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Cyan

$dockerAvailable = $false
try {
    $null = Get-Command docker -ErrorAction Stop
    $null = docker info 2>&1
    if ($LASTEXITCODE -eq 0) {
        $dockerAvailable = $true
    }
} catch {
    $dockerAvailable = $false
}

if ($dockerAvailable) {
    Write-Host "[INFO] Docker detected. Starting n8n container..." -ForegroundColor Yellow
    docker compose up -d
    Write-Host "[SUCCESS] n8n container active on http://localhost:5678" -ForegroundColor Green
    Start-Process "http://localhost:5678"
} else {
    $n8nAvailable = Get-Command n8n -ErrorAction SilentlyContinue
    Start-Job -ScriptBlock {
        Start-Sleep -Seconds 5
        Start-Process "http://localhost:5678"
    } | Out-Null

    if ($n8nAvailable) {
        Write-Host "[INFO] Starting via global n8n..." -ForegroundColor Green
        n8n
    } else {
        Write-Host "[INFO] Starting via npx (Node.js)..." -ForegroundColor Yellow
        npx --yes --legacy-peer-deps n8n
    }
}
