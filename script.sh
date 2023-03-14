#!/usr/bin/env bash

echo "Powered by"
curl -s https://raw.githubusercontent.com/Salvatorenodes/logo/main/logo.sh
sleep 2

echo "Updating and installing packages"
sudo apt update && sudo apt upgrade -y

sleep 1

read -p "Enter your repository name: " EXAMPLE
export RUSTUP_HOME=/workspace/$EXAMPLE

echo "Install rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

sleep 1

source "/workspace/.cargo/env"

sleep 1

echo "Create snarkOS"
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

mkdir demo_deploy_Leo_app && cd demo_deploy_Leo_app

echo "Enter your wallet address"
WALLETADDRESS="$(cat)"

APPNAME=helloworld_"${WALLETADDRESS:4:6}"
leo new "${APPNAME}"
cd "${APPNAME}" && leo run && cd -
PATHTOAPP=$(realpath -q $APPNAME)
cd $PATHTOAPP && cd ..

PRIVATEKEY="$(cat)"

RECORD="$(cat)"

snarkos developer deploy "${APPNAME}.aleo" --private-key "${PRIVATEKEY}" --query "https://vm.aleo.org/api" --path "./${APPNAME}/build/" --broadcast "https://vm.aleo.org/api/testnet3/transaction/broadcast" --fee 600000 --record "${RECORD}"
