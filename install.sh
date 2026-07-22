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

echo -e "\e[34m[Wellcome to Fotfiles Installer]\e[0m"

#ver como pegar se já tem wayland + hyprland baixado
echo -e "\e[33m[Installing Dependencies...]\e[0m"
#sudo pacman -S --needed git curl 

echo -e "\e[33m[Installing Apps...]\e[0m"
#sudo pacman -S --needed fastfetch kitty micro rofi swaync waybar wlogout btop nemo

echo -e "\e[33m[Installing AUR...]\e[0m"
#git clone https://aur.archlinux.org/yay.git
#cd yay
#mkpkg -si

read -r -p "Install ZSH? [y/N]: " answer
answer=${answer:-N}

case "${answer,,}" in
    y|yes)
		echo -e "\e[33m[Installing ZSH...]\e[0m"
		#sudo pacman -S --needed zsh 
		
		echo "List of Plugins:"
		#magenta 
		echo "zsh-autosuggestions     | Auto Suggestions when writtign in terminal"
		echo "zsh-syntax-highlighting | Color if text right or wrong"
		echo "zsh-interactive-cd      | Better cd + tab view with fzf"
		echo "extract                 | Extract any compressed file"
		echo "universalarchive        | Compress any file"

		
		read -r -p "Install ZSH Plugins? [y/N]: " answerP
		answerP=${answerP:-N}
			case "${answerP}" in
				y|yes)
				    #install fzf
					;;
				n|no)
					echo "no"
					;;
				*)
					echo "não vale"
					;;
			esac
			
		echo -e "\e[33m[Installing ZSH...]\e[0m"
		
        ;;
    n|no)
        echo "Cancelado."
        ;;
    *)
        echo "Resposta inválida."
        ;;
esac

echo "Done, enjoy!"
