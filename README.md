# n1ghtfall
A really cool dark terminal theme for Zsh

PLS SELECT THIS OPTION ON YOUR (macOS) TERMINAL SETTINGS!!!!

<img width="459" height="89" alt="Screen Shot 2026-06-14 at 8 19 08 AM" src="https://github.com/user-attachments/assets/4d1c61ce-510b-4717-a091-ad20fa5b3167" />

Features:
* 40+ useful command aliases
* Beginner-friendly interface
* Auto-updates every 1 hour (configurable)
* Backups your original Zsh config
* Easily Uninstallable
* All in Zsh

If you want to remove the "last login (...) at ttys(...)", you can create a dotfile:
```zsh
touch ~/.hushlogin
```

The Zsh config is a dotfile that is stored in your home directory named ```.zshrc```, which n1ghtfall backs up

You can modify the new n1ghtfall Zsh config with this command:
```zsh
nano ~/.zshrc
```
(nano is a usually builtin text editor for terminal)

When you download, your backup zsh will stored in ```zshbackup``` in your home directory

When you want to uninstall, you can run ```nf-uninstall``` to uninstall n1ghtfall

n1ghtfall preview:

<img width="867" height="642" alt="Screen Shot 2026-06-14 at 8 01 08 AM" src="https://github.com/user-attachments/assets/da581712-1813-4fb6-a2e4-79cec75aa4ed" />

## Installation

### First Option (Quickest Way)
Open your terminal and run this command:
```zsh
curl -fsSL 'raw.githubusercontent.com/reorientate/n1ghtfall/refs/heads/main/install.sh' | bash
```
This runs the installer script

**WARNING:** As some of you may know, cURLing a raw script from a site then piping to Bash is a very bad practice, as you can unknowingly install malware onto your device without any security measures

Consider checking out the install.sh script for the paranoid people!

### Second Option

First, open your terminal and type:
```zsh
git clone https://github.com/reorientate/n1ghtfall n1ghtfall
```
then go into the folder:
```zsh
cd n1ghtfall
```
###### (if that doesnt work, try ```cd ~/n1ghtfall```)
then run this:
```zsh
mkdir -p ~/zshbackup && cp ~/.zshrc ~/zshbackup/.zshrc.bak && cp -i .zshrc ~/.zshrc
```
Explanation: Creates a backup --> Copies (or duplicates) the original ```.zshrc``` config **on home** to the backup dir (zshbackup) --> Replaces the .zshrc config with n1ghtfall (with confirmation)

## NOTE
I have only tested this on MacOS, it might not work on other platforms.
