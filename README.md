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


## Overwrite settings
If you want to overwrite certain settings in .vimrc but want to be able to pull from this repository in the future, add a file called ```vimrc_local``` inside the cloned respository folder (```vim-dotfiles```).
