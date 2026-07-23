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

cd $HOME
clear

echo -e "\n\e[34m[Wellcome to Dotfiles Installer]\e[0m"

#ver como pegar se já tem wayland + hyprland baixado
if pacman -S --noconfirm git curl base-devel >/dev/null 2>&1; then
    echo "[Done]"
else
    echo "[Error installing dependencies]"
    exit 1
fi
echo -e "\n\e[33m[Installing Apps...]\e[0m"
sudo pacman -S --needed fastfetch kitty micro rofi swaync waybar btop nemo

echo -e "\n\e[33m[Installing AUR...]\e[0m"
git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay
makepkg -si --noconfirm

echo -e "\n\e[33m[Installing AUR Packages...]\e[0m"
yay -S --needed --noconfirm wlogout
	
echo -e "\n\e[33m[Installing ZSH...]\e[0m"
sudo pacman -S --needed zsh

echo ""
read -r -p "Apply ZSH Default Shell? [Y/n]: " answerZ
answerZ=${answerZ:-Y}
case "${answerP,,}" in
	y|yes)	
		chsh -s /bin/zsh
		;;
	n|no)
		echo -e "\n"
		;;
	*)
		echo "Invalid Option"
		;;
esac
 
echo "\nList of Plugins:"
#magenta 
echo -e "\e[35mzsh-autosuggestions     \e[0m| Auto Suggestions when writtign in terminal"
echo -e "\e[35mzsh-syntax-highlighting \e[0m| Color if text right or wrong"
echo -e "\e[35mzsh-interactive-cd      \e[0m| Better cd + tab view with fzf"
echo -e "\e[35mextract                 \e[0m| Extract any compressed file"
echo -e "\e[35muniversalarchive        \e[0m| Compress any file"


read -r -p "\nInstall ZSH Plugins? [y/N]: " answerP
answerP=${answerP:-N}
case "${answerP}" in
	y|yes)
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

	    zsh
	    
		;;
	n|no)
		echo -e "\n"
		;;
	*)
		echo "Invalid Option"
		;;
esac

echo "Done, enjoy!"
