#!/bin/bash

set -e

RESET='\033[0m'
RED="\033[0;31m"
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

CONTAINER="dotfiles-test"
USER_NAME="jefferson"
PASSWORD="p"

configured=false

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

cleanup() {
    echo
    echo "Removendo container..."
    docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
}

on_exit() {
    if $configured; then
        cleanup
    else
        echo
        echo "========================================="
        echo "A configuração falhou."
        echo "O container foi mantido para depuração."
        echo
        echo "Entre novamente com:"
        echo
        echo "docker exec -it \\"
        echo "  --user $USER_NAME \\"
        echo "  --workdir /home/$USER_NAME/hyprland-dotfiles \\"
        echo "  $CONTAINER bash"
        echo "========================================="
    fi
}

trap on_exit EXIT

docker rm -f "$CONTAINER" >/dev/null 2>&1 || true

if ! run_with_spinner "[Baixando/criando container]" docker run \
    --name "$CONTAINER" \
    -dit \
    -v "$PWD:/home/$USER_NAME/hyprland-dotfiles" \
    archlinux:latest; then
    exit 1
fi

if ! run_with_spinner "[Configurando Arch]" docker exec "$CONTAINER" bash -c "
set -e

pacman-key --init
pacman-key --populate archlinux

pacman -Sy --noconfirm \
    git \
    sudo \
    base-devel \
    nano

useradd -m -G wheel -s /bin/bash $USER_NAME || true

echo '$USER_NAME:$PASSWORD' | chpasswd
echo 'root:$PASSWORD' | chpasswd

mkdir -p /etc/sudoers.d
echo '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel

cat >> /home/$USER_NAME/.bashrc <<'EOF'

alias testinstall='cd ~/hyprland-dotfiles && bash install.sh'

EOF

chown -R $USER_NAME:$USER_NAME /home/$USER_NAME
"; then
    exit 1
fi

configured=true

echo
echo "========================================="
echo "Usuário : $USER_NAME"
echo "Senha   : $PASSWORD"
echo "========================================="
echo
echo "Projeto montado em:"
echo "/home/$USER_NAME/hyprland-dotfiles"
echo
echo "Comandos úteis:"
echo "  testinstall"
echo "  ./install.sh"
echo

docker exec \
    -it \
    --user "$USER_NAME" \
    --workdir "/home/$USER_NAME/hyprland-dotfiles" \
    "$CONTAINER" \
    bash -il
