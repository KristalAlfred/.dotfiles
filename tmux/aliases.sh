function t() {
	if [[ $# -eq 1 ]]; then
		selected=$1
	else
		selected=$(find \
			~/git \
			-mindepth 1 -maxdepth 1 -type d | fzf)
	fi

	if [[ -z $selected ]]; then
		return
	fi

	selected_name=$(basename "$selected" | tr . _)
	tmux_running=$(pgrep tmux)

	if [[ -z $TMUX ]]; then
		tmux new-session -As $selected_name -c $selected
		return
	fi

	if ! tmux has-session -t=$selected_name 2>/dev/null; then
		tmux new-session -ds $selected_name -c $selected
	fi

	tmux switch-client -t $selected_name
}
