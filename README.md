# .dotfiles
My personal collection of dotfiles for vim, emacs, bash, zsh and git.

Running `init.(sh|cmd)` will simlink `$HOME/{file}` to `path/to/.dotfiles/{file}`, and back up the original in `path/to/.dotfiles/backup/` as well as pull in all the vim plugin submodules and install emacs packages with cask.

Requirements:
- `cask`
- `org-mode` repo installed in `$HOME/src/`

