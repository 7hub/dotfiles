# Setup fzf
# ---------
if [[ ! "$PATH" == *${FZF_PATH}/bin* ]]; then
  export PATH="$PATH:${FZF_PATH}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${FZF_PATH}/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${FZF_PATH}/shell/key-bindings.zsh"


# Open in tmux popup if on tmux, otherwise use --height mode
#export FZF_DEFAULT_OPTS='--height 40%  --layout reverse --border top'

# for Mac
# install fd & fzf
#$ brew install fd fzf
# bind default key-binding 这里会提示你绑定默认快捷键
#$ /usr/local/opt/fzf/install
# 输出这个命令后，根据提示一路回车
# 生效配置
#$ source ~/.zshrc

# alter filefind to fd 设置环境变量，如果已经自动设置了，就不用重复设置
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND="fd -t d . "





