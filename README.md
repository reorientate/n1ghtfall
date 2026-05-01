# n1ghtfall
A really cool dark terminal theme for Zsh

(Default)
<img width="259" height="161" alt="Screen Shot 2026-04-27 at 9 19 05 PM" src="https://github.com/user-attachments/assets/37b39117-cde7-4f8a-9458-0837e576260e" />

------

<img width="261" height="164" alt="Screen Shot 2026-04-27 at 9 16 34 PM" src="https://github.com/user-attachments/assets/0d8cbe48-d1db-4c15-8fc0-f1f88014d0f7" />
(Alternative prompt)

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
