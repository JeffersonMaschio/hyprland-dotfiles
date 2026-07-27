#!/bin/bash

set -e

CONTAINER="dotfiles-test"
USER_NAME="jefferson"
PASSWORD="p"

configured=false

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

echo "Criando container..."

docker rm -f "$CONTAINER" >/dev/null 2>&1 || true

docker run \
    --name "$CONTAINER" \
    -dit \
    -v "$PWD:/home/$USER_NAME/hyprland-dotfiles" \
    archlinux:latest >/dev/null

echo "Configurando Arch..."

docker exec "$CONTAINER" bash -c "
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
"

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
