#!/usr/bin/env bash

echo "Powered by"
curl -s https://raw.githubusercontent.com/Salvatorenodes/logo/main/logo.sh
sleep 2

echo "Updating and installing packages"
sudo apt update && sudo apt upgrade -y

sleep 1

read -p "Enter your repository name: " EXAMPLE
export RUSTUP_HOME=/workspace/$EXAMPLE

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

sleep 1

source "/workspace/.cargo/env"

sleep 1

git clone https://github.com/AleoHQ/snarkOS.git --depth 1
sleep 1
sudo chown -R gitpod ./snarkOS
cd snarkOS

sudo ./build_ubuntu.sh
source $HOME/.cargo/env
cargo install --path .

sleep 1

cd "$OLDPWD"

git clone https://github.com/AleoHQ/leo
sleep 1
cd leo
cargo install --path .
sleep1
cd "$OLDPWD"
