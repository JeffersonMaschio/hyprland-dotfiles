#!/usr/bin/env bash

#instalador:
#
#Fazer:
# 0.baixar coisas necessárias, tipo: git, waybar, rofi, kitty, etc.
#	[0.1 se for arch puro, baixar Wayland + WM]
# 1. baixar e ativar AUR (yay) 
# 2. instalar ZSH
# 3. baixar apps/pacotes para dotfiles
# 4. baixar dotfiles do repo
#	4.1 aplicar dotfiles com stow (baixar stow (perguntar se quer remover depois de usar))
#
# Amarelo = "\e[33mtexto\e[0m"
# Azul = "\e[34mtexto\e[0m"
# Magenta = "\e[35mtexto\e[0m"

ZSHRC = "$HOME/.zshrc"


echo -e "\e[34m[Wellcome to Fotfiles Installer]\e[0m"

#ver como pegar se já tem wayland + hyprland baixado
echo -e "\e[33m[Installing Dependencies...]\e[0m"
sudo pacman -S --needed git curl 

echo -e "\e[33m[Installing Apps...]\e[0m"
sudo pacman -S --needed fastfetch kitty micro rofi swaync waybar wlogout btop nemo

echo -e "\e[33m[Installing AUR...]\e[0m"
git clone https://aur.archlinux.org/yay.git
cd yay
mkpkg -si
	
echo -e "\e[33m[Installing ZSH...]\e[0m"
sudo pacman -S --needed zsh 
		
echo "List of Plugins:"
#magenta 
echo -e "\e[35mzsh-autosuggestions     \e[0m| Auto Suggestions when writtign in terminal"
echo -e "\e[35mzsh-syntax-highlighting \e[0m| Color if text right or wrong"
echo -e "\e[35mzsh-interactive-cd      \e[0m| Better cd + tab view with fzf"
echo -e "\e[35mextract                 \e[0m| Extract any compressed file"
echo -e "\e[35muniversalarchive        \e[0m| Compress any file"


		
read -r -p "Install ZSH Plugins? [y/N]: " answerP
answerP=${answerP:-N}
case "${answerP}" in
	y|yes)
	    #install fzf
	    zsh
	    sudo pacman -S --needed fzf
	    
	    echo "Downloading zsh-utosuggestions..."
	    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

	    echo "Downloading zsh-syntax-highlighting..."
	    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

	    echo "Activating interactive-cd"
	    sleep 0.5
	    echo "Activing extract"
	    sleep 0.5
	    echo "Activing universalarchive"
	    sleep 0.5

	    echo "Applying Plugins..."
	    if [ -f "$ZSHRC" ]; then
	        sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions\n zsh-syntax-highlighting\n zsh-interactive-cd\n extract\n universalarchive)/' "$ZSHRC"
	        echo "Plugins Added!!"
	    else
	        echo "Error: .zshrc file was not found in the expected location."
	    fi
		;;
	n|no)
		echo -e "\n"
		;;
	*)
		echo "Invalid Option"
		;;
esac

echo "Done, enjoy!"
