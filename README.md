# n1ghtfall
A really cool dark terminal theme for Zsh

 I couldnt find a oh-my-zsh theme that suited me well, so i made my own terminal theme

<img width="560" height="404" alt="Screen Shot 2026-06-26 at 9 16 46 PM" src="https://github.com/user-attachments/assets/64689eb2-46f9-42e5-bb9c-596c2979def4" />
<img width="560" height="404" alt="Screen Shot 2026-06-26 at 9 52 41 PM" src="https://github.com/user-attachments/assets/abf61d46-8edd-4bcd-b297-fde10e27f98f" />

<img width="560" height="404" alt="nfbanneranimtest" src="https://github.com/user-attachments/assets/115ebb34-4b5e-411d-b519-570250774831" />

(banner animation not in the script because its kinda unstable but im working on it!!)

> (these previews are with some terminal settings modified to make it look better)

PLS SELECT THIS OPTION ON YOUR (macOS) TERMINAL SETTINGS!!!!

<img width="459" height="89" alt="Screen Shot 2026-06-14 at 8 19 08 AM" src="https://github.com/user-attachments/assets/4d1c61ce-510b-4717-a091-ad20fa5b3167" />

If you want the best visual experience, you can [download the font i use in previews](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IBMPlexMono.zip) (choose semibold)

## Main stuff

Features:
* 40+ useful command aliases
* Cool look
* (Soon) Banner animation
* Auto-updates every 1 hour (configurable)
* Backups your original Zsh config
* Easily Uninstallable
* All in Zsh

(Recommended) If you want to remove the "last login (...) at ttys(...)", you can just create a file:
```zsh
touch ~/.hushlogin
```

The Zsh config is a dotfile that is stored in your home directory named ```.zshrc```, which n1ghtfall backs up at ```~/.n1ghtfall-backups```

You can modify the new n1ghtfall Zsh config with this command:
```zsh
nano ~/.zshrc
```
(nano is a usually builtin text editor for terminal)

When you download, your backup zsh will stored in ```zshbackup``` in your home directory

When you want to uninstall, you can run ```nf-uninstall``` to uninstall n1ghtfall

## Installation

### First Option (Quickest Way)
Open your terminal and run this command:
```zsh
curl -fsSL 'raw.githubusercontent.com/reorientate/n1ghtfall/refs/heads/main/install.sh' | bash
```
This runs the installer script

> **WARNING:** As some of you may know, cURLing a script from the internet then piping to a shell interpreter (usually sh and bash) is a very bad practice, as you can unknowingly install malware onto your device without any security measures

Consider checking out the install.sh script for the paranoid people!

### Second Option (for the people that dont like curling and piping to shell)

(make sure you are in home directory)

(recommended, but optional) backup your original .zshrc:
```zsh
mkdir -p zshbackup
```
```zsh
mv ~/.zshrc zshbackup 
```
now clone this repo:
```zsh
git clone https://github.com/reorientate/n1ghtfall n1ghtfall
```
then move n1ghtfall .zshrc to home directory
```zsh
mv n1ghtfall/.zshrc ~
```
One-liner for it all:
```zsh
mkdir -p zshbackup && mv ~/.zshrc zshbackup && git clone https://github.com/reorientate/n1ghtfall n1ghtfall && mv n1ghtfall/.zshrc && clear && source ~/.zshrc
```

Restart terminal or ```source ~/.zshrc``` to load!

## NOTE
this theme might not work or might not look that good on other platforms because im too lazy (and dont have that much storage space) to make virtual machines
