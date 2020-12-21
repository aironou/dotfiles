#!/bin/sh
USER="$(whoami)"
HOME="$(getent passwd $USER | cut -d : -f 6)"
DOTFILES_DIRECTORY="$HOME/.dotfiles"

log() {
    echo "$(date) $@"
}

install_dependencies() {
    log ">>> installing dependencies"
    sudo apt update
    sudo apt install -y git htop httpie nmap vim zsh --fix-missing
}

clone_dotfiles() {
    log ">>> cloning dotfiles"
    if [ -d $DOTFILES_DIRECTORY ] && [ -d $DOTFILES_DIRECTORY/.git ]
    then
        cd $DOTFILES_DIRECTORY
        git checkout -- .
        git pull
    else
        git clone https://github.com/aironou/dotfiles $DOTFILES_DIRECTORY
    fi
}

install_oh_my_zsh() {
    log ">>> installing oh-my-zsh"
    RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    log ">>> installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

copy_config_files() {
    log ">>> copying congig files"
    CONFIG_DIRECTORY=$DOTFILES_DIRECTORY/config
    cp $CONFIG_DIRECTORY/wsl.conf /etc/.
    cp $CONFIG_DIRECTORY/.p10k.zsh $HOME/.
    cp $CONFIG_DIRECTORY/.zshrc $HOME/.
    touch $HOME/.hushlogin
    mkdir -p $HOME/.config/htop
    cp $CONFIG_DIRECTORY/htoprc $HOME/.config/htop/.
    mkdir -p $HOME/.ssh
    cp $CONFIG_DIRECTORY/ssh.config $HOME/.ssh/config
}

generate_ssh_keys() {
    log ">>> generating SSH keys"
    for SSHFILE in "aironou-github.com aironou-gitlab.com"
    do
        ssh-keygen -q -t ed25519 -N "" -f $HOME/.ssh/$SSHFILE
        log ">>> $SSHFILE"
        cat $HOME/.ssh/$SSHFILE
        echo
    done

}

main() {
    cd $HOME
    install_dependencies
    clone_dotfiles
    install_oh_my_zsh
    generate_ssh_keys
    copy_config_files
}


main