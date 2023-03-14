#!/usr/bin/env bash

echo "Powered by"
curl -s https://raw.githubusercontent.com/Salvatorenodes/logo/main/logo.sh

sleep 2

#!/bin/bash

echo "Updating and installing packages"
sudo apt update && sudo apt upgrade -y

sleep 1

expect <<EOF
spawn curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
expect "Proceed with installation" { send -- "\r" }
expect eof
EOF

sleep 1

git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS

sudo ./build_ubuntu.sh
source $HOME/.cargo/env
cargo install --path .

sleep 1

cd -
