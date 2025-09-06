.PHONY: install install-symlink update sync uninstall

install:
	@bash scripts/install.sh

install-symlink:
	@bash scripts/install.sh --symlink

update:
	@nvim --headless "+Lazy! sync" +qa

sync: update

uninstall:
	@bash scripts/uninstall.sh
