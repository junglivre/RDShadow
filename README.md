# RDShadow - Ferramenta de Sombreamento de Área de Trabalho Remota

![Versão](https://img.shields.io/github/v/release/junglivre/RDShadow)

pt-BR | [en-US](README_en.md)

Uma ferramenta simples e elegante para conectar e controlar sessões de Remote Desktop (RDP) em sistemas Windows, com interface visual moderna e opções de controle flexíveis.

## 📋 Características

- **Interface moderna**: Menu visual com bordas ASCII estilizadas
- **Duas opções de controle**:
  - Com permissão do usuário (usuário vê notificação)
  - Sem permissão do usuário (conexão silenciosa)
- **Listagem completa**: Visualize usuários conectados e sessões do sistema
- **Navegação intuitiva**: Opção X para voltar ao menu em qualquer tela
- **Visual responsivo**: Cores e emojis para melhor experiência

## 🚀 Como usar

### Opção 1: Script Batch (.cmd)
1. Baixe o arquivo `RDShadow_br.cmd`
2. Execute como Administrador (obrigatório)
3. Escolha uma das opções do menu:
   - **[1]** Com permissão de acesso do usuário
   - **[2]** Sem permissão de acesso do usuário  
   - **[9]** Listar usuários conectados
   - **[0]** Sair

### Opção 2: Executável (.exe)
1. Vá para a seção [Releases](https://github.com/junglivre/RDShadow/releases/latest)
2. Baixe a versão compilada (.exe) desejada:
   - `RDShadow_br.exe` (Versão em Português - Brasil)
   - `RDShadow_en.exe` (Versão em Inglês)
3. Execute o arquivo (já solicita permissões de admin automaticamente)

## 🛠️ Requisitos

- Windows Server ou Windows com Terminal Services habilitado
- Permissões de Administrador
- Usuários logados no sistema para conectar

## 💡 Dicas de uso

- Para voltar ao menu principal, digite **X** em qualquer prompt
- IDs de sessão são mostrados nos comandos `query user` e `qwinsta`
- A opção **[2]** conecta sem avisar o usuário (útil para suporte técnico)
- A opção **[9]** é ideal para visualizar todas as sessões disponíveis

## 📖 Comandos utilizados

- `query user` - Lista usuários conectados
- `qwinsta` - Lista todas as sessões do sistema  
- `mstsc /shadow:ID /control` - Conecta à sessão com controle
- `mstsc /shadow:ID /control /noconsentprompt` - Conecta sem permissão

## 🔧 Versões disponíveis

- **Script**: `RDShadow_br.cmd` (Português - Brasil) / `RDShadow_en.cmd` (Inglês)
- **Executável**: Disponível na seção [Releases](https://github.com/junglivre/RDShadow/releases/latest)

---

⚠️ **Aviso**: Esta ferramenta deve ser usada apenas em sistemas próprios ou com autorização adequada. O uso inadequado pode violar políticas de privacidade e segurança.