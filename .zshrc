# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin
# echo $PATH
# Path to your oh-my-zsh installation.
export ZSH="/home/robwal01/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
# uncomment the following
# plugins=(git)




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







###############################################
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate

# disable ls colouring for executable files
## bold RED
# export LS_COLORS="ex=0:di=01;31:"
## not bold grey RED to match highlighting tab completion below
export LS_COLORS="ex=0:di=31;31:"
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*:parameters'  list-colors '=*=32'
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' list-prompt   ''

zstyle ':completion:*' special-dirs true

# highligh tab completed part of the directory
# zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==31=31}:${(s.:.)LS_COLORS}")';

zstyle :compinstall filename '/home/robwal01/.zshrc'
autoload -Uz compinit
compinit
# # show hidden dirs then tab autocompletion
# _comp_options+=(globdots)

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
bindkey -e
# End of lines configured by zsh-newuser-install

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


###############################################
# ZSH DEFAULTS REMAPPING


# This tells zsh that small letters will match small and capital letters. (i.e. capital letters match only capital letters.)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# If you want that capital letters also match small letters use instead:
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'



###############################################
# custom prompt
export PROMPT="
%T %m %~% > "



###############################################
# zsh tab completion on empty line
# https://unix.stackexchange.com/questions/14230/zsh-tab-completion-on-empty-line
# expand-or-complete-or-list-files
function expand-or-complete-or-list-files() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="ls "
        CURSOR=3
        zle list-choices
        zle backward-kill-word
    else
        zle expand-or-complete
    fi
}
zle -N expand-or-complete-or-list-files
# bind to tab
bindkey '^I' expand-or-complete-or-list-files




###############################################
# zsh git completion very slow
# https://superuser.com/questions/458906/zsh-tab-completion-of-git-commands-is-very-slow-how-can-i-turn-it-off
__git_files () { 
    _wanted files expl 'local files' _files     
}


###############################################
# zsh kill word on slack / not _
# zsh: stop backward-kill-word on directory delimiter
# https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
autoload -U select-word-style
select-word-style normal



###############################################
# CUSTOM ALIASSES
source /home/robwal01/zsh/plugins/arm/zsh-setup.zsh
module load arm/cluster


alias l="ls --group-directories-first"
alias ll="ls -la --group-directories-first"
# alias ll="ls -ltra --group-directories-first --color=tty "
alias pd="pushd"

set autolist
export GREP_OPTIONS='--color=auto' # highlight grep results


alias ge="gedit"
# start emacs in unibyte mode to see all the encoded characters
alias ew="emacs"
alias em="emacsclient -n"
alias e="emacsclient -n"
alias emc="/tools/bin/emacsclient-23.3 -n"

# alias nautnautilus='--no-desktop --browser'
alias naut="nautilus --no-desktop --browser -g 1220x500+700+0 . &"
alias nn="nautilus --no-desktop --browser -g 1220x500+700+0 . "

alias fg="find | grep -i"
alias ff=find . -type f -printf \'"%T@ %TY_%Tm_%Td-%Tr %P\n"\' \| sort -n \| awk \''{print $2 $3, $4}'\'


# alias fgf='echo "find . -name '*.yaml' -exec grep "sv" {} \; -print"'

alias ack="~/bin/ack"

alias v="gvim"
alias vv="gvim --servername GVIM --remote-tab "

alias dh="cat ~/bin/displayhelp"
alias edh="e ~/bin/displayhelp"
alias vh="gvim ~/bin/displayhelp"

alias p4merge="/arm/tools/perforce/p4merge/2015.2.1315639/linux/bin/p4merge"
alias p4="p4merge"
alias pm="p4merge"
alias meldd="molo meld/meld/3.14.0"

alias cds="cd /arm/projectscratch/pd/pj00410/users/robwal01/"
alias cdp="cd /projects/pd/pj00410/users/robwal01/"
alias cdj="cd /arm/projectscratch/pd/pj00410/jenkins/home/workspace/"
alias cda="cd /projects/pd/pj00410/users/robwal01/automation/fpga-workarea/"
alias cdn="ssh login3.nahpc.arm.com -XY"
alias cd101="ssh haps-arm3-c25-1 -XY"
alias cd103="ssh haps-arm3-c25-40 -XY"
alias cd104="ssh haps-arm3-c25-40 -XY"
alias cd468="ssh s110-a04-1.nahpc.arm.com -XY"
alias cd061="ssh s110-d06-1.nahpc.arm.com -XY"
alias cdpr="ssh vp3800306-host -XY"
alias cd2="ssh login2.euhpc2.arm.com -XY"

alias xterm="xterm -fg white -bg black"

alias moli="module list" 
alias molo="module load" 
alias mola="module load automation/farm_toolkit" 
# alias mla="eval `/arm/devsys-tools/abs/setup_wh_comp Farm:toolkit:0.0:66`"
alias mla="module load /projects/pd/pj00410/users/robwal01/fpga-workarea/linux-x86_64/bin/modulefile.development"

alias d="dirs -v"
alias pd="pushd"
alias po="popd"

alias tf="tail -f "

alias clonefuf="git clone ssh://robwal01@eu-gerrit-2.euhpc.arm.com:29418/fpga/FPGA_projects"

module load util
module load eda
module load swdev
module load apache/subversion/1.9.4
module load git/git/2.16.1
module load python/python/2.7.8
module load python/git-review_py2.7.8/1.26.0
module load vim/vim/7.3
module load gnu/emacs/26.1
module load jonas/tig/2.4.1

# jq to parse json format, e.g.  fpga cat-board --name HAPS101 | jq '.'
module load stedolan/jq/1.5
# git review instead of direct push
molo python/git-review_py2.7.8/1.25.0

# alias j4b="echo setenv DISPLAY $DISPLAY > /arm/projectscratch/pd/pj00410/users/robwal01/sandbox/DISPLAY_SET_ENV.csh; cp ~/.Xauthority /arm/projectscratch/pd/pj00410/users/robwal01/sandbox/.Xauthority; chmod 755 /arm/projectscratch/pd/pj00410/users/robwal01/sandbox/.Xauthority; ssh bitbld02@gb-hpc-jenkins4 -XY"
# alias j4="echo setenv DISPLAY $DISPLAY > /arm/projectscratch/pd/pj00410/users/robwal01/sandbox/DISPLAY_SET_ENV.csh; cp ~/.Xauthority /arm/projectscratch/pd/pj00410/users/robwal01/sandbox/.Xauthority; ssh gb-hpc-jenkins4 -XY"
alias j4b="ssh bitbld02@gb-hpc-jenkins4 -XY"
alias j4="ssh gb-hpc-jenkins4 -XY"


export CDJ="/arm/projectscratch/pd/pj00410/jenkins/home/workspace/"
export CDP="/projects/pd/pj00410/users/robwal01/"
export CDS="/arm/projectscratch/pd/pj00410/users/robwal01/"

# use tree instead of ls to display directory structure
alias t="tree -L 1 --dirsfirst -C"

alias f="firefox"

# save latest shell history to execute in the next window
alias hh="history -S"
# display history
alias h="history"

alias syncauto="molo arm/datasync/2.0; datasync /projects/pd/pj00410/users/robwal01/automation nahpc:/arm/projectscratch/pd/pj00410/users/robwal01/"
alias syncfuf="rsync /projects/pd/pj00410/users/robwal01/fpga_unified_flow/fpga_unified_flow.py* login3.nahpc.arm.com:/arm/tools/arm/fuf/dev/"
alias scpa="scp -r /projects/pd/pj00410/users/robwal01/fpga-workarea/linux-x86_64/bin robwal01@vp3800306-host.cambridge.arm.com:/usr/local/robwal01/fpga-workarea/linux-x86_64/"
alias scp_bin_to_cdpr="scp -r /projects/pd/pj00410/users/robwal01/fpga-workarea/primofarm/primo_bin/. robwal01@vp3800306-host.cambridge.arm.com:/usr/local/robwal01/fpga-workarea/linux-x86_64/"

alias gpp="grep -riT"
# unalias gp
# display source file but replace colon with space, while still highlighling keyword
function gp() {
        grep -riT "$@" * | sed 's/:/ /' | grep -i --no-filename "$@"
}

# cat JSON file and pipe it to jq for parsing
function cj() {
        cat "$@" | jq '.'
}


# # clean HISTFILE to keep command line history specific to current shell
# export HISTFILE=""
# instead, update ~/.oh-my-zsh/lib/history.zsh
# and comment out the following
#setopt share_history          # share command history data

# display files when running tab completion on cd
# zstyle ':completion:*' list-dirs-first true
compdef _path_files cd


# PASTE STRING ON KEY BIND
# https://stackoverflow.com/questions/44258585/how-to-insert-text-into-input-prompt-using-zsh-zle
pasteJqCommand () {
    text_to_add=" | jq '.'"
    RBUFFER=${text_to_add}${RBUFFER}
}
zle -N pasteJqCommand
bindkey '^J' pasteJqCommand
