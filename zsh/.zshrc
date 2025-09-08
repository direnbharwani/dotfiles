# Load modular zsh configuration files
for file in ~/.zsh/*.zsh; do
  [ -r "$file" ] && source "$file"
done
