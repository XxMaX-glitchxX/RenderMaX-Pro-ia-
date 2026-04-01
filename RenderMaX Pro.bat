@echo off
setlocal enabledelayedexpansion
title RenderMaX Pro
mode con: cols=110 lines=40

:: --- HABILITAR COLORES ANSI ---
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "cCYAN=%ESC%[36m"
set "cGREEN=%ESC%[32m"
set "cRED=%ESC%[31m"
set "cYELLOW=%ESC%[33m"
set "cWHITE=%ESC%[37m"
set "cRESET=%ESC%[0m"

:: --- COMPROBAR PRIVILEGIOS DE EJECUCION ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    set "ADMIN_STATUS=%cRED%Usuario Estandar (Requiere Elevacion)%cRESET%"
    :: Auto-elevar privilegios
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
) else (
    set "ADMIN_STATUS=%cGREEN%Administrador (Privilegios Maximos)%cRESET%"
)

:: --- OBTENER INFO DEL SISTEMA Y USUARIO ---
set "USER_NAME=%USERNAME%"
for /f "skip=1 delims=" %%A in ('wmic os get caption') do (
    for /f "tokens=*" %%B in ("%%A") do set "OS_NAME=%%B"
)

:: --- ESTADOS VISUALES ---
set "sOFF=%cRED%[OFF]%cRESET%"
set "sON=%cGREEN%[ON]%cRESET%"

set "o1=!sOFF!" & set "o2=!sOFF!" & set "o3=!sOFF!"
set "o4=!sOFF!" & set "o5=!sOFF!" & set "o6=!sOFF!"
set "o7=!sOFF!" & set "o8=!sOFF!" & set "o9=!sOFF!"
set "o10=!sOFF!" & set "o11=!sOFF!" & set "o12=!sOFF!"

:MENU
cls
echo.
echo %cCYAN%  ==============================================================================================%cRESET%
echo %cWHITE%                                   RENDERMAX PRO - CONTROL TOTAL%cRESET%
echo %cCYAN%  ==============================================================================================%cRESET%
echo     %cYELLOW%Usuario  :%cRESET% %USER_NAME%
echo     %cYELLOW%Sistema  :%cRESET% %OS_NAME%
echo     %cYELLOW%Ejecucion:%cRESET% %ADMIN_STATUS%
echo %cCYAN%  ==============================================================================================%cRESET%
echo.
echo      %cCYAN%SISTEMA Y REPARACION                        LIMPIEZA Y ESPACIO%cRESET%
echo    %cCYAN%--------------------------                  ---------------------------%cRESET%
echo     [1] Reparar Imagen DISM     !o1!            [4] Limpiar Temporales      !o4!
echo     [2] Analizar Archivos SFC   !o2!            [5] Vaciar Papelera         !o5!
echo     [3] Optimizar Update (Base) !o3!            [6] Limpiar Prefetch/Cache  !o6!
echo.
echo      %cCYAN%GAMING Y RENDIMIENTO                        PERSONALIZACION (Visual)%cRESET%
echo    %cCYAN%--------------------------                  ---------------------------%cRESET%
echo     [7] Desactivar Telemetria   !o7!            [10] Activar Modo Oscuro    !o10!
echo     [8] Desactivar Hibernacion  !o8!            [11] Menu Contextual Clasico !o11!
echo     [9] Optimizar DNS/Red       !o9!            [12] Desactivar Copilot     !o12!
echo.
echo      %cCYAN%ESPECIALES%cRESET%
echo    %cCYAN%--------------------------%cRESET%
echo     %cYELLOW%[M]%cRESET% OPTIMIZAR MINECRAFT (Logs, Shaders y Java Cache)
echo     %cYELLOW%[D]%cRESET% OPTIMIZAR DISCOS (TRIM para SSD / Desfragmentar HDD)
echo.
echo     %cGREEN%[A] --- EJECUTAR CAMBIOS SELECCIONADOS ---%cRESET%          %cCYAN%[P] PUNTO DE RESTAURACION%cRESET%
echo     %cRED%[R] --- MENU DE RESTAURACION (REVERTIR) ---%cRESET%         [X] SALIR
echo.
echo %cCYAN%  ==============================================================================================%cRESET%
set /p "ch= %cYELLOW%^> Selecciona una opcion o letra:%cRESET% "

if "%ch%"=="1" (if "!o1!"=="!sOFF!" (set "o1=!sON!") else (set "o1=!sOFF!")) & goto MENU
if "%ch%"=="2" (if "!o2!"=="!sOFF!" (set "o2=!sON!") else (set "o2=!sOFF!")) & goto MENU
if "%ch%"=="3" (if "!o3!"=="!sOFF!" (set "o3=!sON!") else (set "o3=!sOFF!")) & goto MENU
if "%ch%"=="4" (if "!o4!"=="!sOFF!" (set "o4=!sON!") else (set "o4=!sOFF!")) & goto MENU
if "%ch%"=="5" (if "!o5!"=="!sOFF!" (set "o5=!sON!") else (set "o5=!sOFF!")) & goto MENU
if "%ch%"=="6" (if "!o6!"=="!sOFF!" (set "o6=!sON!") else (set "o6=!sOFF!")) & goto MENU
if "%ch%"=="7" (if "!o7!"=="!sOFF!" (set "o7=!sON!") else (set "o7=!sOFF!")) & goto MENU
if "%ch%"=="8" (if "!o8!"=="!sOFF!" (set "o8=!sON!") else (set "o8=!sOFF!")) & goto MENU
if "%ch%"=="9" (if "!o9!"=="!sOFF!" (set "o9=!sON!") else (set "o9=!sOFF!")) & goto MENU
if "%ch%"=="10" (if "!o10!"=="!sOFF!" (set "o10=!sON!" ) else (set "o10=!sOFF!")) & goto MENU
if "%ch%"=="11" (if "!o11!"=="!sOFF!" (set "o11=!sON!" ) else (set "o11=!sOFF!")) & goto MENU
if "%ch%"=="12" (if "!o12!"=="!sOFF!" (set "o12=!sON!" ) else (set "o12=!sOFF!")) & goto MENU

if /i "%ch%"=="M" goto MINECRAFT
if /i "%ch%"=="D" goto DISKS
if /i "%ch%"=="A" goto EXECUTE
if /i "%ch%"=="P" goto RPOINT
if /i "%ch%"=="R" goto RESTORE_MENU
if /i "%ch%"=="X" exit
goto MENU

:EXECUTE
cls
echo %cYELLOW%[!] Aplicando cambios...%cRESET%
if "!o1!"=="!sON!" dism /online /cleanup-image /restorehealth
if "!o2!"=="!sON!" sfc /scannow
if "!o3!"=="!sON!" dism /online /cleanup-image /startcomponentcleanup /resetbase
if "!o4!"=="!sON!" del /s /f /q "%temp%\*.*" >nul 2>&1
if "!o5!"=="!sON!" powershell -command "$bin=(New-Object -ComObject Shell.Application).NameSpace(10); $bin.items() | foreach { remove-item $_.path -Recurse -Force }"
if "!o6!"=="!sON!" del /s /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
if "!o7!"=="!sON!" reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
if "!o8!"=="!sON!" powercfg.exe /hibernate off
if "!o9!"=="!sON!" (ipconfig /flushdns & netsh winsock reset) >nul 2>&1
if "!o10!"=="!sON!" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f
)
if "!o11!"=="!sON!" reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1
if "!o12!"=="!sON!" reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo %cGREEN%[OK] Tareas completadas. Reinicia para aplicar algunos cambios.%cRESET%
pause
goto RESET_VARS

:RESET_VARS
for /l %%i in (1,1,12) do set "o%%i=!sOFF!"
goto MENU

:MINECRAFT
cls
echo %cYELLOW%[+] Optimizando carpetas de Minecraft...%cRESET%
if exist "%AppData%\.minecraft" (
    del /s /f /q "%AppData%\.minecraft\logs\*.*" >nul 2>&1
    if exist "%AppData%\.minecraft\shadercaches" rd /s /q "%AppData%\.minecraft\shadercaches"
    echo %cGREEN%[OK] Cache y Logs eliminados.%cRESET%
) else (
    echo %cRED%[!] No se encontro la carpeta de Minecraft.%cRESET%
)
pause
goto MENU

:DISKS
cls
echo %cYELLOW%[+] Optimizando unidades de almacenamiento...%cRESET%
echo %cYELLOW%[+] Enviando comando TRIM a SSDs y optimizando HDDs...%cRESET%
defrag /C /O
echo %cGREEN%[OK] Discos optimizados.%cRESET%
pause
goto MENU

:RPOINT
cls
echo %cYELLOW%[+] Creando punto de seguridad...%cRESET%
powershell -command "Checkpoint-Computer -Description 'RenderMaX_Point' -RestorePointType 'MODIFY_SETTINGS'"
echo %cGREEN%[OK] Punto de restauracion creado (si el sistema lo permite).%cRESET%
pause
goto MENU

:RESTORE_MENU
cls
echo %cYELLOW%[!] Restaurando valores por defecto...%cRESET%
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 0 /f >nul 2>&1
powercfg.exe /hibernate on
echo %cGREEN%[OK] Configuraciones revertidas.%cRESET%
pause
goto MENU