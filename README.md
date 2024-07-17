# Dotfiles  management using Gnu.stow


## install git , neovim, zsh, gnu.stow, fzf, tmux
```bash
$ sudo apt install fzf git zsh
$ sudo apt install zoxide git 
$ cd ~
$ git clone https://github.com/LazyVim/starter ~/.config/nvim
$ rm -rf ~/.config/nvim/.git
```

## Dotfiles management using `yadm`

```sh
sudo apt install yadm
cd ~
yadm pull 


## install `oh-my-tmux`

```
$ cd
$ git clone https://github.com/gpakosz/.tmux.git
$ ln -s -f .tmux/.tmux.conf
$ cp .tmux/.tmux.conf.local .
```

```

```


