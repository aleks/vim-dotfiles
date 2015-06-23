# Vim Dotfiles

## Requirements

You need to clone [Vundle](https://github.com/gmarik/Vundle.vim) to your home directory (just clone it, no .vimrc file needed):

```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Run Dotfile Installation

```
git clone https://github.com/aleks/vim-dotfiles.git
ln -s vim-dotfiles/vimrc .vimrc
ln -s vim-dotfiles/vimrc.bundles .vimrc.bundles
```

Start ```vim```, run ```:PluginInstall```. done!
