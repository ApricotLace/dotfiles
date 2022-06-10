symlink-doom-config:
	ln -s "$(CURDIR)/.doom.d" ~/.doom.d

spin-up-shell:
	ln -s "$(CURDIR)/.fzf.zsh" ~/.fzf.zsh
	ln -s "$(CURDIR)/.gitconfig" ~/.gitconfig
	ln -s "$(CURDIR)/.p10k.zsh" ~/.p10k.zsh
	ln -s "$(CURDIR)/.zprofile" ~/.zprofile
	ln -s "$(CURDIR)/.zshrc" ~/.zshrc
