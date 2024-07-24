export FZF_PATH=${HOME}/.fzf

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/hq/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/hq/.fzf/bin"
fi

eval "$(fzf --bash)"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${FZF_PATH}/shell/completion.bash" 2>/dev/null

# Key bindings
# ------------
source "${FZF_PATH}/shell/key-bindings.bash"
