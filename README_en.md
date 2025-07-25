# RDShadow - Remote Desktop Shadow Tool

![Version](https://img.shields.io/github/v/release/junglivre/RDShadow)

[pt-BR](README.md) | en-US

A simple and elegant tool to connect and control Remote Desktop (RDP) sessions on Windows systems, featuring a modern visual interface and flexible control options.

## 📋 Features

- **Modern interface**: Visual menu with stylized ASCII borders
- **Two control options**:
  - With user permission (user sees notification)
  - Without user permission (silent connection)
- **Complete listing**: View connected users and system sessions
- **Intuitive navigation**: X option to return to menu on any screen
- **Responsive visual**: Colors and emojis for better experience

## 🚀 How to use

### Option 1: Batch Script (.cmd)
1. Download the `RDShadow_en.cmd` file
2. Run as Administrator (required)
3. Choose one of the menu options:
   - **[1]** With user access permission
   - **[2]** Without user access permission
   - **[9]** List connected users
   - **[0]** Exit

### Option 2: Executable (.exe)
1. Go to the [Releases](https://github.com/junglivre/RDShadow/releases/latest) section
2. Download the desired compiled version (.exe):
   - `RDShadow_br.exe` (Portuguese - Brazil Version)
   - `RDShadow_en.exe` (English Version)
3. Run the file (automatically requests admin permissions)

## 🛠️ Requirements

- Windows Server or Windows with Terminal Services enabled
- Administrator permissions
- Users logged into the system to connect to

## 💡 Usage tips

- To return to the main menu, type **X** at any prompt
- Session IDs are shown in `query user` and `qwinsta` commands
- Option **[2]** connects without notifying the user (useful for technical support)
- Option **[9]** is ideal for viewing all available sessions

## 📖 Commands used

- `query user` - Lists connected users
- `qwinsta` - Lists all system sessions
- `mstsc /shadow:ID /control` - Connects to session with control
- `mstsc /shadow:ID /control /noconsentprompt` - Connects without permission

## 🔧 Available versions

- **Script**: `RDShadow_br.cmd` (Portuguese - Brazil) / `RDShadow_en.cmd` (English)
- **Executable**: Available in [Releases](https://github.com/junglivre/RDShadow/releases/latest) section

---

⚠️ **Warning**: This tool should only be used on your own systems or with proper authorization. Improper use may violate privacy and security policies.