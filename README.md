# cfgs
======

My personal configs.

Requirements:
- git
- ansible

Install ansible:
- sudo apt-get install software-properties-common
- sudo apt-add-repository ppa:ansible/ansible
- sudo apt-get update
- sudo apt-get install ansible -y
- sudo ansible-galaxy install -r ~/cfgs/ansible/requirements.yml

Install:
- git clone https://github.com/melihovv/cfgs.git ~/cfgs
- ~/cfgs/ansible/init.sh

Running `ansible/init.sh` will
- install:
    - zsh
    - antigen with oh-my-zsh and awesome zsh plugins
    - bash-it
    - git
    - git-number
    - tmux
    - tree
    - fasd
- make zsh default shell for specified user
- simlink `$HOME/{file}` to `path/to/.dotfiles/{file}`. WARNING: it will
override any existing files!
- pull in all the vim plugin submodules.

Configs for:
- bash
- zsh
- tmux
- git
- vim
- emacs
- fasd
- and more...

