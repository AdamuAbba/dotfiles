export DEV_SERVICES="$HOME/.config/dev-services"

#========================== Helper functions =================================
#------- bitcoin
d-btc-up(){
docker compose --file="$DEV_SERVICES/bitcoin/docker-compose.yaml" up -d
CONTAINER_ID=$(docker compose --file="$DEV_SERVICES/bitcoin/docker-compose.yaml" ps -q bitcoin)

# Export to a file/env var
echo "export BTC_CONTAINER_ID=$CONTAINER_ID" > "$HOME/.btc_container_env"
echo "Container ID: $CONTAINER_ID"
echo "written BTC_CONTAINER_ID to $HOME/.btc_container_env"
}

d-btc-nuke() {
  source ~/.btc_container_env
  container_id=$(docker rm --volumes --force "$BTC_CONTAINER_ID")
  echo "Nuked container 💣: $container_id"
}
