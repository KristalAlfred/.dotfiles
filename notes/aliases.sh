export ZK_NOTEBOOK_DIR=$HOME/zk/notes

function notes() {
    git -C "$HOME/zk" "$@"
}
