#!/bin/sh

# exit immediately if password-manager-binary is already in $PATH
type op >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
    brew install 1password-cli
    ;;
Linux)
    if uname -r | grep -q "microsoft"; then
        # WSL
        if command -v op.exe >/dev/null 2>&1; then
            sudo  ln -s $(which op.exe) "/usr/local/bin/op"
        else
            echo "op.exe not found in WSL"
            exit 1
        fi
    else
        # non-WSL Linux
        if command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy --noconfirm --needed 1password-cli
        elif command -v apt >/dev/null 2>&1; then
            curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
            sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
            sudo tee /etc/apt/sources.list.d/1password.list && \
            sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/ && \
            curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
            sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
            sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
            curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
            sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
            sudo apt update && sudo apt install 1password-cli
        else
            echo "unsupported Linux distribution"
            exit 1
        fi
    fi
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac