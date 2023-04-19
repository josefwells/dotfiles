#!/bin/bash
########################################################
# .make.sh
# This script creates symlinks from the home directory
# to any desired dotfiles in ~/dotfiles
########################################################

########## Variables

dir=~/dotfiles                    # dotfiles directory
sdir=~/dotfiles/dotfiles_secure   # secure directory
olddir=~/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc bashrc_history emacs emacs.d vnc cshrc pdbrc tmux.conf tmux"
# files that might exist under dotfiles/dotfiles_secure
securefiles="bashrc.secure bashrc.telegram bashrc.telegram_dale bashrc.telegram_cerfturingmonitor check_on_turing"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
rm -Rf $olddir
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then
# create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [ ! -e $dir/$file ]; then
	continue
    fi
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# move any existing dotfiles in homedir to dotfiles_old directory, then
# create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $securefiles; do
    if [ ! -e $sdir/$file ]; then
	continue
    fi
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $sdir/$file ~/.$file
done

