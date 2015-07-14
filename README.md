# .dotfiles
My personal collection of dotfiles for vim, bash and git.

Running init.(sh|cmd) will simlink $HOME/{file} to path/to/.dotfiles/{file} original file doesn't exist as well as pull in all the vim plugin submodules.

Make sure that .bash_aliases is called from your .bashrc:

`echo "if [ -f $HOME/.bash_aliases ]; then . $HOME/.bash_aliases; fi" >> ~/.bashrc`

Configure git to use the global gitignore_global

`git config --global core.excludesfile ~/.gitignore_global`
