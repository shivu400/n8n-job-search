@echo off
title Nagendra n8n Safe Job Automation Launcher
color 0A

echo ========================================================
echo    🚀 Nagendra M.P - Safe Job Automation (n8n + Gemini)
echo ========================================================
echo.

:: Check if Docker is installed and running
where docker >nul 2>nul
if %ERRORLEVEL% equ 0 (
    docker info >nul 2>nul
    if %ERRORLEVEL% equ 0 (
        echo [INFO] Docker detected and running. Launching via Docker Compose...
        docker compose up -d
        echo.
        echo [SUCCESS] n8n is running in the background!
        echo Opening http://localhost:5678 in your browser...
        start http://localhost:5678
        goto end
    )
)

:: If Docker is not running, check for global n8n or run npx with legacy peer deps
where n8n >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo [INFO] Found global n8n installation. Starting...
    start "" cmd /c "timeout /t 4 >nul && start http://localhost:5678"
    n8n
    goto end
)

echo [INFO] Docker not active. Launching via npx (Node.js)...
echo [NOTE] Opening http://localhost:5678 in 8 seconds...
start "" cmd /c "timeout /t 8 >nul && start http://localhost:5678"
npx --yes --legacy-peer-deps n8n

:end
echo.
echo Press any key to exit this window...
pause >nul
