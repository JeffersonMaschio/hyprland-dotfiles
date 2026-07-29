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

RED="\033[0;31m"
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
 
ZSHRC="$HOME/.zshrc"
PACKAGES=(fastfetch kitty micro rofi swaync waybar btop nemo)

run_with_spinner() {
    local message="$1"
    shift

    local logfile
    logfile="$(mktemp)"

    "$@" >"$logfile" 2>&1 &
    local pid=$!

    local spin_chars='\|/-'
    local i=0

    printf "%s " "$message"
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r%s %s" "$message" "${spin_chars:i++%${#spin_chars}:1}"
        sleep 0.1
    done

    wait "$pid"
    local status=$?

    if [ $status -eq 0 ]; then
        printf "\r%s ${GREEN}[Done]${RESET}\n" "$message"
    else
        printf "\r%s ${RED}[Error]${RESET}\n" "$message"
        echo -e "${RED}Saída do comando:${RESET}"
        cat "$logfile"
    fi

    rm -f "$logfile"
    return $status
}

cd $HOME
clear
printf "\n${BLUE}[Wellcome to Dotfiles Installer]${RESET}\n"

sudo -v || exit 1

#ver como pegar se já tem wayland + hyprland baixado
sleep 0.5
if ! run_with_spinner "[Installing Dependencies]" sudo pacman -S --needed --noconfirm git curl base-devel stow; then
    exit 1
fi

sleep 0.5
if ! run_with_spinner "[Installing Apps]" sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"; then
    exit 1
fi

if command -v yay >/dev/null 2>&1; then
    printf "${GREEN}[yay is already installed]${RESET}\n"
else
    printf "\n${YELLOW}[Installing AUR]${RESET}\n"
    sleep 0.5

	if ! run_with_spinner "[Clonning yay]" git clone https://aur.archlinux.org/yay.git "$HOME/yay"; then
		exit 1
	fi

    cd "$HOME/yay" || exit 1
    
    if ! run_with_spinner "[Compiling]" makepkg -si --noconfirm; then
    	exit 1
    fi

    cd "$HOME" || exit 1
fi

sleep 0.5
if ! run_with_spinner "[Installing AUR Packages]" yay -S --needed --noconfirm wlogout; then
	exit 1
fi

sleep 0.5
if ! run_with_spinner "[Installing ZSH]" sudo pacman -S --needed --noconfirm zsh; then
	exit 1
fi

echo ""
read -r -p "Apply ZSH Default Shell? [Y/n]: " answerZ
answerZ=${answerZ:-Y}
case "${answerZ,,}" in
	[Yy]|[Yy][Ee][Ss])
		printf "${YELLOW}[Applying...]${RESET}\n"	
		sleep 0.5
		sudo usermod -s /bin/zsh "$USER"
		printf "${GREEN}[Done]${RESET}\n"		
		;;
	[Nn]|[Nn][Oo])
		printf "\n"
		;;
	*)
		printf "${RED}[Invalid Option]${RESET}\n"
		;;
esac
 
printf "\nList of Plugins:\n"
#magenta 
printf "${PURPLE}zsh-autosuggestions     ${RESET}| Auto Suggestions when writtign in terminal\n"
printf "${PURPLE}zsh-syntax-highlighting ${RESET}| Color if text right or wrong\n"
printf "${PURPLE}zsh-interactive-cd      ${RESET}| Better cd + tab view with fzf\n"
printf "${PURPLE}extract                 ${RESET}| Extract any compressed file\n"
printf "${PURPLE}universalarchive        ${RESET}| Compress any file\n"

echo ""
read -r -p "Install ZSH Plugins? [Y/n]: " answerP
answerP=${answerP:-Y}
case "${answerP,,}" in
	[Yy]|[Yy][Ee][Ss])
	    run_with_spinner "[Installing fzf]" sudo pacman -S --needed --noconfirm fzf
	    
	    run_with_spinner "[Downloading zsh-autosuggestions]" git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

	    run_with_spinner "[Downloading zsh-syntax-highlighting]" git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

	    printf "${YELLOW}[Activating interactive-cd]${RESET}\n"
	    sleep 0.5
	    printf "${YELLOW}[Activing extract]${RESET}\n"
	    sleep 0.5
	    printf "${YELLOW}[Activing universalarchive]${RESET}\n"
	    sleep 0.5

	    printf "${YELLOW}[Applying Plugins...]${RESET}\n"
	    if [ -f "$ZSHRC" ]; then
	        sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions\n zsh-syntax-highlighting\n zsh-interactive-cd\n extract\n universalarchive)/' "$ZSHRC"
	        printf "${GREEN}[Plugins Added]${RESET}\n"
	    else
	        printf "${RED}[Error: .zshrc file was not found in the expected location]${RESET}\n"
	    fi	    
		;;
	[Nn]|[Nn][Oo])
		printf "\n"
		;;
	*)
		printf "${RED}[Invalid Option]${RESET}\n"
		;;
esac

printf "${YELLOW}[Creating Symlinks for Config Files...]${RESET}\n"
mv $HOME/hyprland-dotfiles $HOME/dotfiles
cd $HOME/dotfiles

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


#substituir o .zshrc default pelo meu.




echo "[Done, enjoy!]"
