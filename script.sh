#!/usr/bin/env bash

echo "Powered by"
curl -s https://raw.githubusercontent.com/Salvatorenodes/logo/main/logo.sh

sleep 2

echo "Updating and installing packages"
sudo apt update && sudo apt upgrade -y
sleep 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh | expect <<EOF
  spawn curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  sleep 1
  expect "Current installation options" { send -- "1\r" }
  
  
sleep 1
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS
sleep 1
./build_ubuntu.sh
sleep 1
source $HOME/.cargo/env
sleep 1
cargo install --path .
sleep 1
cd -
