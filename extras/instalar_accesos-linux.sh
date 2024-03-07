#!/bin/bash

chmod +x ./bin/*

cp ./bin/* ~/.local/bin/

ln -s ~/.local/bin/emacs-editor ~/.local/bin/eed
ln -s ~/.local/bin/emacs-eval ~/.local/bin/eev
