# cfgs

My personal configs.

Requirements:
- git (to clone this repo)
- ansible

Install ansible:
- sudo apt install software-properties-common
- sudo apt-add-repository ppa:ansible/ansible
- sudo apt update
- sudo apt install ansible -y

Install git:
- sudo apt install git

Install configs:
- git clone https://github.com/melihovv/cfgs.git ~/cfgs
- cd ~/cfgs
- ansible-galaxy install -r requirements.yml
- ansible-playbook main.yml

Running `ansible-playbook main.yml` will install
- zsh, antigen, oh-my-zsh and other awesome zsh plugins
- bash-it
- git
- tmux and some cool tmux plugins
- tree
- fasd
- fzf
- vim
- emacs with spacemacs
- configs for lubuntu

To install only specific roles:
- ansible-playbook main.yml --tags=zsh,vim

To exclude specific roles from install:
- ansible-playbook main.yml --skip-tags=bash,emacs
