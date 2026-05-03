# n1ghtfall
A really cool dark terminal theme for Zsh

It has:
* 40+ useful command aliases
* Beginner-friendly interface
* All in Zsh

preview:
<img width="867" height="649" alt="Screen Shot 2026-05-03 at 1 54 47 AM" src="https://github.com/user-attachments/assets/9102d4d2-ed49-42dd-ad3f-56eec35e9d37" />

## Installation

### First Option (Quickest Way)
Open your terminal and run this command:
```zsh
curl -fsSL 'raw.githubusercontent.com/reorientate/n1ghtfall/refs/heads/main/install.sh' | bash
```

This runs the installer script

To uninstall:
```zsh
curl -O 'https://raw.githubusercontent.com/reorientate/n1ghtfall/refs/heads/main/uninstall.sh' && bash uninstall.sh && rm uninstall.sh
```

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
