# my-dotfiles

## cloning repo

To use this configuration run:
```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotrepo/ --work-tree=$HOME'
git clone --bare git@github.com:PanPaskuda/my-dotfiles.git $HOME/.dotrepo
dotrepo checkout
```

to write alias to bashrc run:
```sh
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotrepo/ --work-tree=$HOME'" >> $HOME/.dotrepo
```


Alternatively for HTTP access run:
```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotrepo/ --work-tree=$HOME'
git clone --bare https://github.com/PanPaskuda/my-dotfiles.git $HOME/.dotrepo
dotrepo checkout
```


dotfiles repo strategy based on the idea [described here](https://www.atlassian.com/git/tutorials/dotfiles)

<br>

## TODO:
+ add windows .bat version of scripts
+ add support for windows in vimrc

+ add main script to call all desired scripts
+ create one script for windows and linux
+ rewrite gitconfig to use it as script
+ add base of .bashrc and manage local changes
