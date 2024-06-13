# Setup fzf
# ---------
if [[ ! "$PATH" == */home/hq/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/hq/.fzf/bin"
fi

source <(fzf --zsh)
