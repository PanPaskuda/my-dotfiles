# my-dotfiles

## cloning repo

To use this configuration run:
```sh
sudo apt install --assume-yes git
alias dotrepo='/usr/bin/git --git-dir=$HOME/.dotrepo/ --work-tree=$HOME'
git clone --bare git@github.com:PanPaskuda/my-dotfiles.git $HOME/.dotrepo
dotrepo config --local status.showUntrackedFiles no
dotrepo checkout
```

to write alias to bashrc run:
```sh
echo "alias dotrepo='/usr/bin/git --git-dir=$HOME/.dotrepo/ --work-tree=$HOME'" >> $HOME/.bashrc
```


Alternatively for HTTP access run:
```sh
alias dotrepo='/usr/bin/git --git-dir=$HOME/.dotrepo/ --work-tree=$HOME'
git clone --bare https://github.com/PanPaskuda/my-dotfiles.git $HOME/.dotrepo
dotrepo config --local status.showUntrackedFiles no
dotrepo checkout
```


dotfiles repo strategy based on the idea [described here](https://www.atlassian.com/git/tutorials/dotfiles)

<br>

## TODO:
+ auto install  this repo

+ add windows .bat version of scripts
+ add support for windows in vimrc

+ add main script to call all desired scripts
+ create one script for windows and linux
+ rewrite gitconfig to use it as script
+ add base of .bashrc and manage local changes
