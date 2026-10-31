@echo off
setlocal EnableExtensions
title Xuper TV - Instalador para Roku
cd /d "%~dp0"

echo.
echo   ================================================================
echo      Instalador de Xuper TV para Roku
echo   ================================================================
echo.
echo   Antes: activa el modo desarrollador en el Roku con el mando:
echo   Inicio x3, Arriba x2, Derecha, Izquierda, Derecha, Izquierda, Derecha
echo   (anota la IP y la clave que te pida).
echo.

set "IP=%~1"
if "%IP%"=="" set /p "IP=  IP del Roku: "
set "PASS=%~2"
if "%PASS%"=="" set /p "PASS=  Clave del modo desarrollador: "
if "%IP%"=="" exit /b 1
if "%PASS%"=="" exit /b 1

where tar >nul 2>&1
if errorlevel 1 (
    echo   [X] Este Windows no trae "tar" ^(hace falta Windows 10 version 1803 o mas nuevo^).
    pause
    exit /b 1
)
where curl >nul 2>&1
if errorlevel 1 (
    echo   [X] Este Windows no trae "curl".
    pause
    exit /b 1
)

set "ZIP=%TEMP%\xupertv-roku.zip"
if exist "%ZIP%" del "%ZIP%"
tar -a -cf "%ZIP%" manifest source components images
if errorlevel 1 (
    echo   [X] No pude crear el paquete.
    pause
    exit /b 1
)

echo.
echo   Instalando en el Roku %IP% ...
curl -s --digest -u "rokudev:%PASS%" -F "mysubmit=Install" -F "archive=@%ZIP%" "http://%IP%/plugin_install" -o "%TEMP%\roku-resp.html"
if errorlevel 1 (
    echo   [X] No consigo hablar con el Roku. Revisa la IP y que este en la misma red.
    pause
    exit /b 1
)
findstr /i /c:"Install Success" /c:"Identical to previous" "%TEMP%\roku-resp.html" >nul
if errorlevel 1 (
    echo   [X] El Roku no confirmo la instalacion. Revisa la clave del modo desarrollador.
    echo       Respuesta guardada en %TEMP%\roku-resp.html
) else (
    echo   LISTO: el canal "Xuper TV" ya esta en el Roku.
)
echo.
pause
