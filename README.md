# Vim Dotfiles

## Requirements

I use [vim-plugin](https://github.com/junegunn/vim-plug) to handle my plugins. You just need to clone this repository, add symlinks and run ```:PlugInstall```. No need to install extra plugin managers.

## Dotfile Installation

```
git clone https://github.com/aleks/vim-dotfiles.git vim-dotfiles
ln -s vim-dotfiles/vimrc .vimrc
ln -s vim-dotfiles/vim .vim
```

Start ```vim```, run ```:PlugInstall```. done!


## Overwrite settings
If you want to overwrite certain settings in .vimrc but want to be able to pull from this repository in the future, add a file called ```vimrc_local``` inside the cloned respository folder (```vim-dotfiles```).
