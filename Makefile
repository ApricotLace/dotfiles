symlink-doom-config:
	ln -s "$(CURDIR)/.doom.d" ~/.doom.d

spin-up-shell:
	ln -sf "$(CURDIR)/.fzf.zsh" ~/.fzf.zsh
	ln -sf "$(CURDIR)/.gitconfig" ~/.gitconfig
	ln -sf "$(CURDIR)/.gitmessage" ~/.gitmessage
	ln -sf "$(CURDIR)/.p10k.zsh" ~/.p10k.zsh
	ln -sf "$(CURDIR)/.zprofile" ~/.zprofile
	ln -sf "$(CURDIR)/.zshrc" ~/.zshrc
