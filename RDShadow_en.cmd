@echo off
color 09
chcp 65001 >nul 2>&1
title RDShadow - Remote Desktop Shadow Tool - @junglivre

:menu
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                      RDShadow - Main Menu                    ║
echo   ║                                                              ║
echo   ║                        by www.jung.moe                       ║
echo   ╠══════════════════════════════════════════════════════════════╣
echo   ║                                                              ║
echo   ║  How do you want to control the user session?                ║
echo   ║                                                              ║
echo   ║  [1] With user access permission                             ║
echo   ║  [2] Without user access permission                          ║
echo   ║                                                              ║
echo   ║  [9] List connected users (view only)                        ║
echo   ║                                                              ║
echo   ║  [0] Configure Shadow permissions                            ║
echo   ║                                                              ║
echo   ║  [X] Exit                                                    ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
set /p "option=Choose an option: "

if "%option%"=="1" goto connect_with_permission
if "%option%"=="2" goto connect_without_permission  
if "%option%"=="9" goto list_users
if "%option%"=="0" goto configure_shadow
if /i "%option%"=="x" goto exit_program
goto invalid_option

:connect_with_permission
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║               Connection WITH User Permission                ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo Active sessions:
echo ----------------
query user
echo.
set /p "session_id=Enter the session ID to connect (or X to go back): "

if /i "%session_id%"=="x" goto menu
if "%session_id%"=="" (
    echo.
    echo ❌ Session ID cannot be empty!
    timeout /t 2 >nul
    goto menu
)

echo.
echo 🔗 Connecting to session %session_id% (with permission)...
start mstsc /shadow:%session_id% /control
goto menu

:connect_without_permission
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║              Connection WITHOUT User Permission              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo Active sessions:
echo ----------------
query user
echo.
set /p "session_id=Enter the session ID to connect (or X to go back): "

if /i "%session_id%"=="x" goto menu
if "%session_id%"=="" (
    echo.
    echo ❌ Session ID cannot be empty!
    timeout /t 2 >nul
    goto menu
)

echo.
echo 🔗 Connecting to session %session_id% (without permission)...
start mstsc /shadow:%session_id% /control /noconsentprompt
goto menu

:list_users
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                       Connected Users                        ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
query user
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                       System Sessions                        ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
qwinsta
echo.
set /p "session_id=Enter the session ID to view (or X to go back): "

if /i "%session_id%"=="x" goto menu

echo.
echo 🔗 Connecting to session %session_id%...
mstsc /shadow:%session_id% /noConsentPrompt
goto menu

:configure_shadow
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║               Shadow Permissions Configuration               ║
echo   ╠══════════════════════════════════════════════════════════════╣
echo   ║                                                              ║
echo   ║  Choose the Shadow permission level:                         ║
echo   ║                                                              ║
echo   ║  [0] Disable Shadow                                          ║
echo   ║                                                              ║
echo   ║  [1] Full control with consent                               ║
echo   ║  [2] Full control without consent                            ║
echo   ║                                                              ║
echo   ║  [3] View only with consent                                  ║
echo   ║  [4] View only without consent                               ║
echo   ║                                                              ║
echo   ║  [X] Back to main menu                                       ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
set /p "shadow_option=Choose an option: "

if /i "%shadow_option%"=="x" goto menu
if "%shadow_option%"=="0" goto set_shadow_0
if "%shadow_option%"=="1" goto set_shadow_1
if "%shadow_option%"=="2" goto set_shadow_2
if "%shadow_option%"=="3" goto set_shadow_3
if "%shadow_option%"=="4" goto set_shadow_4
goto invalid_option

:set_shadow_0
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 0 /f
echo ✅ Shadow disabled successfully!
timeout /t 2 >nul
goto menu

:set_shadow_1
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 1 /f
echo ✅ Shadow configured for full control with consent!
timeout /t 2 >nul
goto menu

:set_shadow_2
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 2 /f
echo ✅ Shadow configured for full control without consent!
timeout /t 2 >nul
goto menu

:set_shadow_3
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 3 /f
echo ✅ Shadow configured for view only with consent!
timeout /t 2 >nul
goto menu

:set_shadow_4
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 4 /f
echo ✅ Shadow configured for view only without consent!
timeout /t 2 >nul
goto menu

:invalid_option
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                          ❌ ERROR ❌                        ║
echo   ╠══════════════════════════════════════════════════════════════╣
echo   ║                                                              ║
echo   ║         Invalid option! Please choose a valid option.        ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
timeout /t 2 >nul
goto menu

:exit_program
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                            Exiting...                        ║
echo   ║                                                              ║
echo   ║                   Thanks for using RDShadow!                 ║
echo   ║                                                              ║
echo   ║                         by www.jung.moe                      ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
timeout /t 2 >nul
exit /b 0