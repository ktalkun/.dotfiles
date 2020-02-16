# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/kirill/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"

if [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git mvn fzf zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Переменная плагина zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'
 
#	 _____ __________
#	|  ___|__  /  ___|
#	| |_    / /| |_
#	|  _|  / /_|  _|
#	|_|   /____|_|
#	

# Переменные fzf
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow -g "!{.git,node_modules}/*" 2> /dev/null'
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 100%"
export FZF_CTRL_T_OPTS="--height 100% --preview 'bat --style=numbers --color=always --theme='solarized' {}'"

# Функции fzf, которые вызываются при использовании fzf  через **
function _fzf_compgen_path() {
	rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null
}
function _fzf_compgen_dir() {
	rg --hidden --files --null "$1" 2>/dev/null | xargs -0 dirname | awk '!h[$0]++'
}

#	  ____ _   _ ____ _____ ___  __  __ 
#	 / ___| | | / ___|_   _/ _ \|  \/  |
#	| |   | | | \___ \ | || | | | |\/| |
#	| |___| |_| |___) || || |_| | |  | |
#	 \____|\___/|____/ |_| \___/|_|  |_|
#	                                    
#	 _____ _   _ _   _  ____ _____ ___ ___  _   _ ____  
#	|  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | / ___| 
#	| |_  | | | |  \| | |     | |  | | | | |  \| \___ \ 
#	|  _| | |_| | |\  | |___  | |  | | |_| | |\  |___) |
#	|_|    \___/|_| \_|\____| |_| |___\___/|_| \_|____/ 
#	                                                    

# Перемещение по директориям в интерактивном режиме с использованием fzf
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# Открытие директории, в которой находится искомый файл с помощью fzf
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Открытие директории, искомой также среди скрытых при помощи fzf
cdh() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# Завершить процессы, найденные и помеченные при помощи fzf
function fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
zle -N fkill

# Провести поиск, используя fzf, среди файлов содержащий переданную функции строку
function fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Найти и открыть файл в vim
function fof() {
  local out file key
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}
 
# Сохранить картинку, находящуюся в буфере обмена
function clip2img() {
	 xclip -selection clipboard -t image/png -o > "$1"
}

#	 _   _  ___ _____ _  _________   ______  
#	| | | |/ _ \_   _| |/ / ____\ \ / / ___| 
#	| |_| | | | || | | ' /|  _|  \ V /\___ \ 
#	|  _  | |_| || | | . \| |___  | |  ___) |
#	|_| |_|\___/ |_| |_|\_\_____| |_| |____/ 
#	

bindkey -s '^f' 'fif '
bindkey -s '^q' 'fof'
bindkey -s '^[f' 'ranger'
bindkey '^x' fkill

zle -N autosuggest-toggle _zsh_autosuggest_toggle_widget
bindkey '^s' autosuggest-toggle
 
zle -N autosuggest-fetch _zsh_autosuggest_fetch_widget
bindkey '^ ' autosuggest-fetch
 
bindkey '^w' backward-kill-word
bindkey '^[w' kill-word
bindkey '^k' backward-word
bindkey '^j' forward-word

#	    _    _     ___    _    ____  _____ ____  
#	   / \  | |   |_ _|  / \  / ___|| ____/ ___| 
#	  / _ \ | |    | |  / _ \ \___ \|  _| \___ \ 
#	 / ___ \| |___ | | / ___ \ ___) | |___ ___) |
#	/_/   \_\_____|___/_/   \_\____/|_____|____/ 
#	                                             

alias gdw="cd ~/Downloads"
alias gho="cd ~"
