NOTES_DIR=$HOME/zk
if [[ -d "$NOTES_DIR" ]]; then 
    echo "$NOTES_DIR already exists."
    exit 0
fi

gh repo clone KristalAlfred/zk $HOME/zk
