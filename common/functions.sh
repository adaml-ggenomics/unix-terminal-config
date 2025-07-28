
proj() {
  local target=$1
  local base dir

  # Turn on case-insensitive matching for [[ … == … ]]
  shopt -s nocasematch

  for base in "$HOME/projects" "$HOME/Documents/projects"; do
    [ -d "$base" ] || continue

    # Loop through each child of that base
    for dir in "$base"/*; do
      [ -d "$dir" ] || continue
      # Compare the basename of $dir to $target, ignoring case
      if [[ "$(basename "$dir")" == "$target" ]]; then
        cd "$dir" && { shopt -u nocasematch; return; }
      fi
    done
  done

  # Turn nocasematch back off
  shopt -u nocasematch

  echo "Project '$target' not found in ~/projects or ~/Documents/projects."
}