# Visually select containers
dsel() {
docker ps --format "{{.Names}}\t{{.Image}}\t{{.ID}}\t{{.CreatedAt}}" | awk '
  {
    # Adjust the output format here
    printf("%-20s\t%-30s\t%s\t%s\n", $1, $2, $3, $4 " " $5 " " $6);
  }' | fzf -m
}

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

dimgid() {
  docker images --format "{{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.ID}}\t{{.CreatedAt}}" | awk '
    {
      # Adjust the output format here
      printf("%-30s\t%-20s\t%s\t%s\n", $1, $2, $3, $4 " " $5 " " $6);
    }' | fzf | awk '{ print $4 }'
}

# Remove selected image together with its containers
dimgrm() {
  local img_id=$(dimgid)

  if [[ -z "$img_id" ]]; then
    echo "No image selected."
    return
  fi

  local containers_using=$(docker ps -a --filter "ancestor=$img_id" --format "{{.ID}}\t{{.Names}}")

  if [[ -n "$containers_using" ]]; then
    echo "The following container(s) are using the image $img_id:"
    echo "$containers_using"
    echo -n "Would you like to force delete this image and its containers? [y/N] "

    read response

    if [[ "$response" =~ ^[Yy]$ ]]; then
      echo "Stopping and removing containers..."
      echo "$containers_using" | awk '{print $1}' | xargs -r docker rm -f
      echo "Removing image $img_id..."
      docker rmi -f "$img_id"
    else
      return
    fi
  else
    if ! output=$(docker rmi "$img_id" 2>&1); then
      echo "Failed to remove image: $img_id"
      echo "$output"
      echo -n "Would you like to force remove this image? [y/N] "
      
      read force_response

      if [[ "$force_response" =~ ^[Yy]$ ]]; then
        if docker rmi -f "$img_id"; then
          echo "Successfully forced removal of image: $img_id"
        else
          echo "Failed to force remove image: $img_id"
        fi
      else
        echo "Not forcing removal of image: $img_id"
      fi
    else
      echo "Successfully removed image: $img_id"
    fi
  fi
}

