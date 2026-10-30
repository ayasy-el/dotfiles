# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/ayasy/.zshrc'
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Enable menu selection (highlighting options for navigation)
zmodload zsh/complist

# Auto suggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Use Tab to navigate forward in the completion menu
bindkey -M menuselect '^I' menu-complete

# Optional: Use Shift+Tab to navigate backward in the completion menu
bindkey -M menuselect '^[[Z' reverse-menu-complete

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
# Home and End Key Bindings
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

export PATH="$PATH:/usr/local/go/bin:/home/ayasy/.local/bin:/var/lib/snapd/snap/bin:/home/ayasy/go/bin"
export PATH="/home/ayasy/.cargo/bin:$PATH"


source <(fx --comp zsh)

alias ls='eza --icons=auto'
alias note='notesmd-cli'

# bun completions
[ -s "/home/ayasy/.bun/_bun" ] && source "/home/ayasy/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# editor
export EDITOR="nvim"
# . "$HOME/.local/bin/env"


# Dynamic System Paths
export WALLPAPER_DIR="/home/ayasy/Pictures/Wallpapers"


canmon() {
    local interface="can0"
    local filter=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -i)
                [[ -n "$2" ]] || {
                    echo "Usage: canmon [-i interface] [-Y filter]" >&2
                    return 1
                }
                interface="$2"
                shift 2
                ;;
            -Y)
                [[ -n "$2" ]] || {
                    echo "Error: -Y requires a display filter" >&2
                    return 1
                }
                filter="$2"
                shift 2
                ;;
            *)
                echo "Unknown argument: $1" >&2
                echo "Usage: canmon [-i interface] [-Y filter]" >&2
                return 1
                ;;
        esac
    done

    stdbuf -oL tshark -q -i "$interface" \
        -d can.subdissector=iso15765 \
        -d iso15765.subdissector=uds \
        -T fields \
        -E separator='|' \
        -e frame.number \
        -e frame.time_relative \
        -e can.id \
        -e can.len8dlc \
        -e iso15765.padding \
        -e _ws.col.Info \
        ${filter:+-Y "$filter"} 2>/dev/null |
    stdbuf -oL awk -F'|' '{
        data=$5
        gsub(/../, "& ", data)
        sub(/ $/, "", data)

        printf "%-5s\t%-13s\t0x%-5X\t%-25s\t%-3s\t%s\n",
               $1, $2, $3, data, $4, $6
        fflush()
    }'
}


precmd() {
    print -Pn "\e]133;A\e\\"
}


export _JAVA_AWT_WM_NONREPARENTING=1

# opencode
export PATH=/home/ayasy/.opencode/bin:$PATH


# Added by Antigravity CLI installer
export PATH="/home/ayasy/.local/bin:$PATH"

export PATH="$PATH:/home/ayasy/.foundry/bin"
source $HOME/.python_env/bin/activate
