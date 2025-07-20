export BITCOIN_DIR="$HOME/.bitcoin"
alias bitd="bitcoind -datadir=$BITCOIN_DIR"
alias bit-cli="bitcoin-cli -datadir=$BITCOIN_DIR"

btc_rpc() {
  local cid="$1"
  shift
  docker exec -it "$cid" bitcoin-cli -regtest -rpcuser=alice -rpcpassword=alicekolala "$@"
}
