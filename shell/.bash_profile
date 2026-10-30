#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"

if [ -e /home/ayasy/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ayasy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


# Added by Antigravity CLI installer
export PATH="/home/ayasy/.local/bin:$PATH"
