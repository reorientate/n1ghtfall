# n1ghtfall
A really cool dark terminal theme for Zsh

<img width="261" height="127" alt="Screen Shot 2026-04-27 at 7 52 17 PM" src="https://github.com/user-attachments/assets/9777c000-1abe-43b1-93d0-6e4a605a196a" />

## Installation

First, open your terminal and type:
```zsh
git clone https://github.com/ne0nclidev/n1ghtfall n1ghtfall
```
then go into the folder:
```zsh
cd n1ghtfall
```
###### (if that doesnt work, try ```cd ~/n1ghtfall```)
then run this:
```zsh
mkdir -p ~/zshbackup && cp ~/.zshrc ~/zshbackup/.zshrc.bak && cp -i nightfall ~/.zshrc
```
Explanation: Creates a backup --> Copies (or duplicates) the original ```.zshrc``` config **on home** to the backup dir (zshbackup) --> Replaces the .zshrc config with n1ghtfall (with confirmation)

## NOTE
I have only tested this on MacOS, it might not work on other platforms.
