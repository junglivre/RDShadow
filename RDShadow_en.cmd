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
echo   ║  [9] List connected users                                    ║
echo   ║  [0] Exit                                                    ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
set /p "option=Choose an option: "

if "%option%"=="1" goto connect_with_permission
if "%option%"=="2" goto connect_without_permission  
if "%option%"=="9" goto list_users
if "%option%"=="0" goto exit_program
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
    pause
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
    pause
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
pause
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