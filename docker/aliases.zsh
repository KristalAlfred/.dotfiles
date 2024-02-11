# Visually select containers
dsel() {
docker ps --format "{{.Names}}\t{{.Image}}\t{{.ID}}\t{{.CreatedAt}}" | awk '
  {
    # Adjust the output format here
    printf("%-20s\t%-30s\t%s\t%s\n", $1, $2, $3, $4 " " $5 " " $6);
  }' | fzf -m}

# Output ID of chosen containers
did() {
  dsel | awk '{ print $3 }'
}

# Output PID of chosen containers
dpid() {
  did | xargs -I {} -P 10 -n 1 docker inspect --format '{{.State.Pid}}' {}
}

# Start bash in a selected container
denter() {
  local container_ids=$(dsel | awk '{ print $1 }' | xargs)
  local -a id_array=($container_ids)
  local container_id="${id_array[@]:0:1}" ## Consistent handling of bash vs. zsh array indexing

  if [[ -n "$container_id" ]]; then
    echo "Connecting to container: $container_id"
    docker exec -it "$container_id" /bin/bash
  else
    echo "No container selected."
  fi
}

# View logs from a selected container
dlog() {
    did | xargs -I {} docker logs -f {}
}
