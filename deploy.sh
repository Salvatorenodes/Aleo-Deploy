#!/usr/bin/env bash

read -p "Enter your repository name: " REPO
cd /workspace/$REPO
sleep 1
rm -r demo_deploy_Leo_app
sleep 1
mkdir demo_deploy_Leo_app && cd demo_deploy_Leo_app
sleep 1
read -p "Enter your wallet address: " WAL
WALLETADDRESS="$WAL"
sleep 1
APPNAME=helloworld_"${WALLETADDRESS:4:6}"
sleep 1
leo new "${APPNAME}"
sleep 1
cd "${APPNAME}" && leo run && cd -
sleep 1
PATHTOAPP=$(realpath -q $APPNAME)
sleep 1
cd $PATHTOAPP && cd ..
sleep 1
read -p "Enter your private key: " PRIV
PRIVATEKEY="$PRIV"
sleep 1
RECORD="$(cat)"
snarkos developer deploy "${APPNAME}.aleo" --private-key "${PRIVATEKEY}" --query "https://vm.aleo.org/api" --path "./${APPNAME}/build/" --broadcast "https://vm.aleo.org/api/testnet3/transaction/broadcast" --fee 600000 --record "${RECORD}"
