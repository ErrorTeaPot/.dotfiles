#!/bin/bash

sudo dnf install lightdm gnome-keyring libsecret
systemctl enable --now --user gcr-ssh-agent.socket
