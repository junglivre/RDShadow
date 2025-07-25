@echo off
color 09
chcp 65001 >nul 2>&1
title RDShadow - Ferramenta de Sombreamento de Área de Trabalho Remota - @junglivre

:menu
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                   RDShadow - Menu Principal                  ║
echo   ║                                                              ║
echo   ║                        by www.jung.moe                       ║
echo   ╠══════════════════════════════════════════════════════════════╣
echo   ║                                                              ║
echo   ║  Como deseja controlar a sessão do usuário?                  ║
echo   ║                                                              ║
echo   ║  [1] Com permissão de acesso do usuário                      ║
echo   ║  [2] Sem permissão de acesso do usuário                      ║
echo   ║  [9] Listar usuários conectados                              ║
echo   ║  [0] Sair                                                    ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
set /p "opcao=Escolha uma opção: "

if "%opcao%"=="1" goto conectar_com_permissao
if "%opcao%"=="2" goto conectar_sem_permissao  
if "%opcao%"=="9" goto listar_usuarios
if "%opcao%"=="0" goto sair
goto opcao_invalida

:conectar_com_permissao
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║               Conexão COM Permissão do Usuário               ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo Sessões ativas:
echo ----------------
query user
echo.
set /p "session_id=Digite o ID da sessão para conectar (ou X para voltar): "

if /i "%session_id%"=="x" goto menu
if "%session_id%"=="" (
    echo.
    echo ❌ ID da sessão não pode estar vazio!
    pause
    goto menu
)

echo.
echo 🔗 Conectando à sessão %session_id% (com permissão)...
start mstsc /shadow:%session_id% /control
goto menu

:conectar_sem_permissao
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║               Conexão SEM Permissão do Usuário               ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo Sessões ativas:
echo ----------------
query user
echo.
set /p "session_id=Digite o ID da sessão para conectar (ou X para voltar): "

if /i "%session_id%"=="x" goto menu
if "%session_id%"=="" (
    echo.
    echo ❌ ID da sessão não pode estar vazio!
    pause
    goto menu
)

echo.
echo 🔗 Conectando à sessão %session_id% (sem permissão)...
start mstsc /shadow:%session_id% /control /noconsentprompt
goto menu

:listar_usuarios
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                      Usuários Conectados                     ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
query user
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                      Sessões do Sistema                      ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
qwinsta
echo.
set /p "session_id=Digite o ID da sessão para visualizar (ou X para voltar): "

if /i "%session_id%"=="x" goto menu

echo.
echo 🔗 Conectando à sessão %session_id%...
mstsc /shadow:%session_id% /noConsentPrompt
goto menu

:opcao_invalida
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                         ❌ ERRO ❌                           ║
echo   ╠══════════════════════════════════════════════════════════════╣
echo   ║                                                              ║
echo   ║     Opção inválida! Por favor, escolha uma opção válida.     ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
pause
goto menu

:sair
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                           Saindo...                          ║
echo   ║                                                              ║
echo   ║                 Obrigado por usar o RDShadow!                ║
echo   ║                                                              ║
echo   ║                        by www.jung.moe                       ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
timeout /t 2 >nul
exit /b 0