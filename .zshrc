# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="dogenpunk"
ZSH_THEME="lambda"
plugins=(git)

source $ZSH/oh-my-zsh.sh
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="dogenpunk"

#### Vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt

#### Git
export GPG_TTY=$(tty)
export EDITOR=nvim

#### Pip-tools
export PATH=/home/bayes/.local/bin:$PATH

#### Local scripts
[[ -d /home/drone/bin ]] && export PATH="/home/drone/bin:$PATH"

####PyENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
#  eval "$(pyenv init -)"
  eval "$(pyenv init --path)"
fi
#eval "$(pyenv virtualenv-init -)"
#export PATH=`cat .pathhold`


# Include these if present 
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.functions ]] && source ~/.functions

