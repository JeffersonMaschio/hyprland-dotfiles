#!/usr/bin/env bash

#instalador:
#
#Fazer:
# 0.baixar coisas necessárias, tipo: git, waybar, rofi, kitty, etc.
#	[0.1 se for arch puro, baixar Wayland + WM]
# 1. baixar e ativar AUR (yay) 
# 2. instalar ZSH + plugins
# 3. baixar apps/pacotes para dotfiles
# 4. baixar dotfiles do repo
#	4.1 aplicar dotfiles com stow (baixar stow (perguntar se quer remover depois de usar))
#
# Amarelo = "\e[33mtexto\e[0m"
# Azul = "\e[34mtexto\e[0m"
# Magenta = "\e[35mtexto\e[0m"

# Reset Color
RESET='\033[0m'

GREEN='\033[0;32m'
YELLOW='\033[0;33'
BLUE='\033[0;34'
PURPLE='\033[0;35'
 
ZSHRC="$HOME/.zshrc"
PACKAGES=(fastfetch kitty micro rofi swaync waybar btop nemo)




cd $HOME
clear
echo -e "\n${BLUE}[Wellcome to Dotfiles Installer]${RESET}"

sudo -v || exit 1

#ver como pegar se já tem wayland + hyprland baixado
printf "\n${YELLOW}[Installing Dependencies...]${RESET}"
sleep 0.5
if sudo pacman -S --needed --noconfirm git curl base-devel stow >/dev/null 2>&1; then
    echo "${GREEN}[Done]${RESET}"
else
    echo "[Error installing dependencies]"
    exit 1
fi

echo -e "\n${YELLOW}[Installing Apps...]${RESET}"
sleep 0.5
if sudo pacman -S --needed --noconfirm "${PACKAGES[@]}" >/dev/null 2>&1; then
    echo "${GREEN}[Done]${RESET}"
else
    echo "[Error installing dependencies]"
    exit 1
fi

if command -v yay >/dev/null 2>&1; then
    echo "yay is already installed"
else
    echo -e "\n${YELLOW}[Installing AUR...]${RESET}"
    sleep 0.5

    git clone https://aur.archlinux.org/yay.git "$HOME/yay"
    cd "$HOME/yay"
    makepkg -si --noconfirm
fi

echo -e "\n${YELLOW}[Installing AUR Packages...]${RESET}"
sleep 0.5
yay -S --needed --noconfirm wlogout
	
echo -e "\n${YELLOW}[Installing ZSH...]${RESET}"
sleep 0.5
sudo pacman -S --needed --noconfirm zsh

echo ""
read -r -p "Apply ZSH Default Shell? [Y/n]: " answerZ
answerZ=${answerZ:-Y}
case "${answerZ,,}" in
	[Yy]|[Yy][Ee][Ss])
		echo "Applying..."	
		sleep 0.5
		sudo usermod -s /bin/zsh "$USER"
		echo "Done"		
		;;
	[Nn]|[Nn][Oo])
		echo -e "\n"
		;;
	*)
		echo "Invalid Option"
		;;
esac
 
echo -e "\nList of Plugins:"
#magenta 
echo -e "${PURPLE}zsh-autosuggestions     ${RESET}| Auto Suggestions when writtign in terminal"
echo -e "${PURPLE}zsh-syntax-highlighting ${RESET}| Color if text right or wrong"
echo -e "${PURPLE}zsh-interactive-cd      ${RESET}| Better cd + tab view with fzf"
echo -e "${PURPLE}extract                 ${RESET}| Extract any compressed file"
echo -e "${PURPLE}universalarchive        ${RESET}| Compress any file"

echo ""
read -r -p "Install ZSH Plugins? [Y/n]: " answerP
answerP=${answerP:-Y}
case "${answerP,,}" in
	[Yy]|[Yy][Ee][Ss])
	    sudo pacman -S --needed --noconfirm fzf
	    
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

	    echo "${YELLOW}Applying Plugins...${RESET}"
	    if [ -f "$ZSHRC" ]; then
	        sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions\n zsh-syntax-highlighting\n zsh-interactive-cd\n extract\n universalarchive)/' "$ZSHRC"
	        echo "${GREEN}[Plugins Added]${RESET}"
	    else
	        echo "Error: .zshrc file was not found in the expected location."
	    fi	    
		;;
	[Nn]|[Nn][Oo])
		echo -e "\n"
		;;
	*)
		echo "Invalid Option"
		;;
esac

echo -e "${YELLOW}Creating Symlinks for Config Files...]${RESET}"
cd ~/hyprland-dotfiles

stow \
    colors \
    fastfetch \
    hypr \
    kitty \
    micro \
    rofi \
    swaync \
    waybar \
    wlogout







echo "[Done, enjoy!]"
