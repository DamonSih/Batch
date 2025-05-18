@echo off
echo Starting browser process termination...

:: Kill browser processes
echo Stopping all browser processes...
taskkill /F /IM msedge.exe /IM chrome.exe /IM firefox.exe /T
echo All browser processes stopped successfully.

:: Clear Edge cache
echo Checking Edge cache folder...
set "EdgeCachePath=%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache"
if exist "%EdgeCachePath%" (
    echo Edge cache found. Clearing cache...
    del /q /s "%EdgeCachePath%\*.*"
    echo Edge cache cleared successfully.
) else (
    echo Edge cache folder not found, skipping.
)

:: Clear Chrome cache
echo Checking Chrome cache folder...
set "ChromeCachePath=%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache"
if exist "%ChromeCachePath%" (
    echo Chrome cache found. Clearing cache...
    del /q /s "%ChromeCachePath%\*.*"
    echo Chrome cache cleared successfully.
) else (
    echo Chrome cache folder not found, skipping.
)

:: Clear Firefox cache
echo Checking Firefox cache folder...
set "FirefoxCachePath=%APPDATA%\Mozilla\Firefox\Profiles"
if exist "%FirefoxCachePath%" (
    echo Firefox cache found. Clearing cache...
    for /d %%D in ("%FirefoxCachePath%\*\cache2") do (
        rd /s /q "%%D"
    )
    echo Firefox cache cleared successfully.
) else (
    echo Firefox cache folder not found, skipping.
)

:: Network cleanup
echo Starting network cleanup...
ipconfig /flushdns
echo DNS cache flushed.

nbtstat -R
echo NetBIOS names refreshed.

nbtstat -c
echo NetBIOS cache cleared.

ipconfig /release
echo IP address released.

ipconfig /renew
echo IP address renewed.

echo All cleanup operations completed.
pause
