# Load modular zsh configuration files
for file in $HOME/.zsh/*.zsh; do
  [ -r "$file" ] && source "$file"
done
