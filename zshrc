#================================#
   # ZSHRC CONFIGURATION FILE #
#================================#

# Export $PATHs
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/Users/$USERNAME$/Library/Python/3.9/bin

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set ZSH theme for iTerm2
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set if terminal is case-sensitive.
CASE_SENSITIVE="false"

# Set if terminal is hyphen-sensitive.
HYPHEN_INSENSITIVE="true"

# Change / uncomment these values if you want to change update behavior.
# zstyle ':omz:update' mode reminder
zstyle ':omz:update' mode auto

# Set auto-update frequency.
zstyle ':omz:update' frequency 8

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Set if you want command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files, speeds up Git retrevials.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Set which plugins you want loaded. Standard plugins can be found in $ZSH/plugins/. Custom plugins may be added to $ZSH_CUSTOM/plugins/.
plugins=(git zsh-autosuggestions)

# Sourcing
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#=============================#
    # USER CONFIGURATION #
#=============================#

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Reload the plugin to highlight the commands each time Iterm2 starts 
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#=============================#
   # VISUAL CUSTOMISATION # 
#=============================#

# Elements options of left prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
# Elements options of right prompt
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

# Add a new line after the global prompt
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Add a second prompt line for the command
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt 
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"

# Visual customisation of the second prompt line
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi

# Change the git status to red when something isn't committed and pushed
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='red'

# Set tab color to match background color for iTerm2 
echo -e "\033]6;1;bg;red;brightness;43\a"
echo -e "\033]6;1;bg;green;brightness;22\a"
echo -e "\033]6;1;bg;blue;brightness;35\a"

# CLI coloring
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
