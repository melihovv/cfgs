#!/usr/bin/env bash

cd "$(dirname "$0")"

ansible-galaxy install -r requirements.yml
ansible-playbook -i inventory main.yml

