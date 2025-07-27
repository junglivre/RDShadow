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
echo   ║                                                              ║
echo   ║  [9] Listar usuários conectados (apenas visualização)        ║
echo   ║                                                              ║
echo   ║  [0] Configurar permissões de sombreamento                   ║
echo   ║                                                              ║
echo   ║  [X] Sair                                                    ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
set /p "opcao=Escolha uma opção: "

if "%opcao%"=="1" goto conectar_com_permissao
if "%opcao%"=="2" goto conectar_sem_permissao  
if "%opcao%"=="9" goto listar_usuarios
if "%opcao%"=="0" goto configurar_shadow
if /i "%opcao%"=="x" goto sair
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
    timeout /t 2 >nul
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
    timeout /t 2 >nul
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

:configurar_shadow
cls
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║           Configuração de Permissões de Sombreamento         ║
echo   ╠══════════════════════════════════════════════════════════════╣
echo   ║                                                              ║
echo   ║  Escolha o nível de permissão para sombreamento:             ║
echo   ║                                                              ║
echo   ║  [0] Desabilitar sombreamento                                ║
echo   ║                                                              ║
echo   ║  [1] Controle total, com consentimento                       ║
echo   ║  [2] Controle total, sem consentimento                       ║
echo   ║                                                              ║
echo   ║  [3] Apenas visualização, com consentimento                  ║
echo   ║  [4] Apenas visualização, sem consentimento                  ║
echo   ║                                                              ║
echo   ║  [X] Voltar ao menu principal                                ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
set /p "shadow_opcao=Escolha uma opção: "

if /i "%shadow_opcao%"=="x" goto menu
if "%shadow_opcao%"=="0" goto set_shadow_0
if "%shadow_opcao%"=="1" goto set_shadow_1
if "%shadow_opcao%"=="2" goto set_shadow_2
if "%shadow_opcao%"=="3" goto set_shadow_3
if "%shadow_opcao%"=="4" goto set_shadow_4
goto opcao_invalida

:set_shadow_0
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 0 /f
echo ✅ Sombreamento desabilitado com sucesso!
timeout /t 2 >nul
goto menu

:set_shadow_1
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 1 /f
echo ✅ Sombreamento configurado para controle total com consentimento!
timeout /t 2 >nul
goto menu

:set_shadow_2
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 2 /f
echo ✅ Sombreamento configurado para controle total sem consentimento!
timeout /t 2 >nul
goto menu

:set_shadow_3
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 3 /f
echo ✅ Sombreamento configurado para apenas visualização com consentimento!
timeout /t 2 >nul
goto menu

:set_shadow_4
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 4 /f
echo ✅ Sombreamento configurado para apenas visualização sem consentimento!
timeout /t 2 >nul
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
timeout /t 2 >nul
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