<h1 align="center"> n1ghtfall (v3.0.0) </h1>

<h3 align="center"> oh-my-zsh-inspired zsh terminal theme! </h3>

<img width="634" height="462" alt="Screen Shot 2026-08-06 at 6 12 08 PM" src="https://github.com/user-attachments/assets/4b9297a9-0838-42dc-ab86-909a89ae6d70" />

<img width="634" height="462" alt="Screen Shot 2026-08-06 at 6 23 25 PM" src="https://github.com/user-attachments/assets/d882b116-964c-4e7d-bc62-16a1a35dbb48" />

> note: these previews are with some terminal settings modified to make it look better

> [!IMPORTANT]
> Enable `xterm_256color` in your terminal settings!
> 
> <img width="455" height="301" alt="Screen Shot 2026-08-02 at 3 22 05 AM" src="https://github.com/user-attachments/assets/81b4732f-f9b9-472b-8ce0-c19cb6996e4f" />


If you want the best visual experience, you can [download the font i use in previews](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IBMPlexMono.zip) (choose semibold)

## Table of Contents
- [Main stuff](#main-stuff)
- [Requirements](#requirements)
- [Installation](#installation)
- [Updating](#updating)
- [Uninstalling](#uninstalling)
- [Troubleshooting](#troubleshooting)
- [Note](#note)
- [Contributing](#contributing)

## Main stuff

Features:
* 40+ useful command aliases
* Cool look
* (Soon) Banner animation
* Auto-updates every 1 hour (configurable)
* Backups your original Zsh config
* Easily Uninstallable
* All in Zsh

.zshrc code can now be found [in the wiki!](https://github.com/reorientate/n1ghtfall/wiki/n1ghtfall-2.6.5-.zshrc-code)

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

## Requirements

* macOS (other platforms are untested — see the [Note](#note) below)
* Zsh (macOS ships with Zsh by default since Catalina)
* [oh-my-zsh](https://ohmyz.sh/) recommended for the best experience
* A [Nerd Font](https://github.com/ryanoasis/nerd-fonts) (like the one linked above) so icons render correctly
* `git` and `curl` installed

## Installation

### First Option (Quickest Way)
Open your terminal and run this command:
```zsh
curl -fsSL 'raw.githubusercontent.com/reorientate/n1ghtfall/refs/heads/main/install.sh' | bash
```
This runs the installer script

> [!WARNING]
> As some of you may know, cURLing a script from the internet then piping to a shell interpreter (usually sh and bash) is a very bad practice, as you can unknowingly install malware onto your device without any security measures
>
> Consider checking out the install.sh script for the paranoid people!

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
mkdir -p zshbackup && mv ~/.zshrc zshbackup && git clone https://github.com/reorientate/n1ghtfall n1ghtfall && mv n1ghtfall/.zshrc ~ && clear && source ~/.zshrc
```

Restart terminal or ```source ~/.zshrc``` to load!

## Updating

n1ghtfall auto-updates every 1 hour by default (configurable). If you want to check for updates manually, you can re-run the installer or pull the latest changes if you cloned the repo directly.

## Uninstalling

Run:
```zsh
nf-uninstall
```
This restores your original `.zshrc` from `~/.n1ghtfall-backups` (or `zshbackup`, depending on how you installed).

## Troubleshooting

* **Icons look like boxes or question marks:** install a [Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IBMPlexMono.zip) and set it as your terminal font.
* **Colors look washed out:** double check the macOS Terminal setting shown in the screenshot above is enabled.
* **"Last login" message won't go away:** run `touch ~/.hushlogin` as noted above.
* **Something looks broken on Linux/Windows:** see the [Note](#note) below — other platforms aren't officially supported yet.

## NOTE
this theme might not work or might not look that good on other platforms because im too lazy (and dont have that much storage space) to make virtual machines

## Contributing

Issues and pull requests are welcome! If you run into a bug or have an idea for a new alias or feature, feel free to open an issue on GitHub.
