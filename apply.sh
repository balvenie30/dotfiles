#!/usr/bin/env bash

# Exit on error
set -euo pipefail
# Enable nullglob and dotglob to include hidden files and handle empty globs
shopt -s nullglob dotglob
# Uncomment to trace commands
# set -x

# Locate the script directory and dotfiles folder
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles.d"

# Verify dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Error: '$DOTFILES_DIR' not found." >&2
  exit 1
fi

# Collect files, exit if none
files=("$DOTFILES_DIR"/*)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "No files in '$DOTFILES_DIR'. Exiting."
  exit 0
fi

# Process each dotfile
for src in "${files[@]}"; do
  # Ignore non-regular files
  [[ -f "$src" ]] || continue

  filename="$(basename "$src")"
  target_name=${filename%.custom}
  target="$HOME/$target_name"

  # Ensure target exists
  [[ -e "$target" ]] || { touch "$target" && echo "Created '$target'"; }

  include_line="source \"$src\""

  # Add include if missing
  if grep -Eq "^[[:space:]]*(source|include|includeIf).*$src" "$target"; then
    echo "Already includes '$src' in '$target'"
  else
    printf "\n%s\n" "$include_line" >> "$target"
    echo "Added include for '$src' to '$target'"
  fi

done

# Remind user to reload shell configuration
echo
echo "To apply the updated shell configuration, run:"
echo "  source ~/.bashrc"
