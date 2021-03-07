#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    TARGET="$(readlink "$SOURCE")"
    if [[ $SOURCE == /* ]]; then
        SOURCE="$TARGET"
    else
        DIR="$(dirname "$SOURCE")"
        SOURCE="$DIR/$TARGET"
    fi
done
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

BASEDIR=$DIR
SETTINGDIR=$DIR/common
ENVPATH=$BASEDIR/.env
source $ENVPATH

echo ░░ Install with environment variable at $ENVPATH

if [ "$OS" = "DEBIAN" ]; then
    echo -e "░░ Installing on ${GREEN}Debian${NC}"
    ENVPATH=$ENVPATH ./Ubuntu/setup-ubuntu.sh

elif [ "$OS" = "MACOS" ]; then
    echo -e "░░ Installing on ${GREEN}macOS${NC}."
    ENVPATH=$ENVPATH ./MacOS/setup-mac.sh

else

    echo -e "${RED}░░ ERROR: OS not defined${NC}"
    echo -e "${RED}░░ Please choose OS in .env files${NC}"
    exit 100
fi


# Brewfile


echo -e "░░ Installing With ${RED}Brewfile${NC}"
echo -e "░░ ${GREEN}Python3, mas, Programs in Brewfile${NC}"
echo -n "░░ continue? [y/N] "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    if ! which brew
    then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    read -r -s -p "[sudo] sudo password for $(whoami):" pass

    brew bundle

    sudo xattr -dr com.apple.quarantine /Applications/Alfred\ 4.app
    sudo xattr -dr com.apple.quarantine /Applications/Bartender\ 3.app
    sudo xattr -dr com.apple.quarantine /Applications/Cheatsheet.app
    sudo xattr -dr com.apple.quarantine /Applications/Discord.app
    sudo xattr -dr com.apple.quarantine /Applications/Flux.app
    sudo xattr -dr com.apple.quarantine /Applications/Google\ Chrome.app
    sudo xattr -dr com.apple.quarantine /Applications/IntelliJ\ IDEA.app
    sudo xattr -dr com.apple.quarantine /Applications/iStat\ Menus.app
    sudo xattr -dr com.apple.quarantine /Applications/iterm.app
    sudo xattr -dr com.apple.quarantine /Applications/Karabiner-Elements.app
    sudo xattr -dr com.apple.quarantine /Applications/KeepingYouAwake.app
    sudo xattr -dr com.apple.quarantine /Applications/Keka.app
    sudo xattr -dr com.apple.quarantine /Applications/Macs\ Fan\ Control.app
    sudo xattr -dr com.apple.quarantine /Applications/MySQLWorkbench.app
    sudo xattr -dr com.apple.quarantine /Applications/Notion.app
    sudo xattr -dr com.apple.quarantine /Applications/Postman.app
    sudo xattr -dr com.apple.quarantine /Applications/PyCharm.app
    sudo xattr -dr com.apple.quarantine /Applications/Slack.app
    sudo xattr -dr com.apple.quarantine /Applications/Steam.app
    sudo xattr -dr com.apple.quarantine /Applications/Visual\ Studio\ Code.app

    sudo xattr -dr com.apple.quarantine /Applications/KakaoTalk.app
    sudo xattr -dr com.apple.quarantine /Applications/Magnet.app
    sudo xattr -dr com.apple.quarantine /Applications/Xcode.app
    sudo xattr -dr com.apple.quarantine /Applications/Hancom\ Office\ HWP\ 2014\ VP\ Viewer.app
    sudo xattr -dr com.apple.quarantine /Applications/Keynote.app
    sudo xattr -dr com.apple.quarantine /Applications/Pages.app
    sudo xattr -dr com.apple.quarantine /Applications/Numbers.app

    aws configure
fi



# oh my zsh
echo -e "░░ Installing ${RED}Zsh Configuration${NC}"
echo -e "░░ ${GREEN}ohmyzsh, powerlevel10k, zsh-syntax-highlighting, zsh-autosuggestions${NC}"
echo -n "░░ continue? [y/N] "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
    git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    cp -v "$SETTINGDIR/.zshrc" "$HOME/.zshrc"
fi

# git
echo -e "░░ Installing ${RED}Git Configuration${NC}"
echo -e "░░ ${GREEN}.gitconfig .gitignore${NC}"
echo -n "░░ continue? [y/N] "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    ln -sf "$SETTINGDIR/.gitexclude" "$HOME/.gitexclude"
    cp -v "$SETTINGDIR/.gitconfig" "$HOME/.gitconfig"
    echo -e "[user]\n\temail = $GIT_PROFILE_EMAIL\n\tname = $GIT_PROFILE_USERNAME" >>"$HOME/.gitconfig.local"
    if [ "$GIT_PROFILE_COMPANY_SEPERATE" = true ]; then
        mkdir -p "$GIT_PROFILE_COMPANY_REPOSITORY_DIR"
        echo -e "[user]\n\temail = $GIT_PROFILE_COMPANY_EMAIL\n\tname = $GIT_PROFILE_COMPANY_USERNAME" >>"$HOME/.gitconfig.$GIT_PROFILE_COMPANY_NAME"
        echo -e "[includeIf \"gitdir:$GIT_PROFILE_COMPANY_REPOSITORY_DIR\"]\n\tpath = .gitconfig.$GIT_PROFILE_COMPANY_NAME" >>"$HOME/.gitconfig.local"
    fi
fi

# vim
echo -e "░░ Installing ${RED}Vim Configuration${NC}"
echo -n "░░ continue? [y/N] "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    cp -v "$SETTINGDIR/.vimrc" "$HOME/.vimrc"
    if [! -f ~/.vim/colors/base16-classic-dark.vim]; then
        git clone git://github.com/chriskempson/base16-vim.git base16
        cp base16/colors/*.vim ~/.vim/colors/
        rm -rf base16
    fi
    
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
fi

# tmux plugin manager
echo -e "░░ Installing ${RED}Tmux Configuration${NC}"
echo -n "░░ continue? [y/N] "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    cp -v "$SETTINGDIR/.tmux.conf" "$HOME/.tmux.conf"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

# nodejs
if command -v node &>/dev/null; then
    echo -e "░░ Setting up ${RED}node.js${NC}"
    echo -e "░░ ${GREEN}yarn, diff-so-fancy${NC}"
    echo -n "░░ continue? [y/N] "
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        npm -g install yarn
        yarn global add diff-so-fancy
    fi
fi

echo -e "SCRIPT FINISHED\n\n"

exit 0
