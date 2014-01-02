STOW = stow

PACKAGES = shell vim i3 scripts

install: $(PACKAGES)
		$(STOW) -S $^ -t $(HOME)

uninstall: $(PACKAGES)
		$(STOW) -D $^ -t $(HOME)

update: $(PACKAGES)
		$(STOW) -R $^ -t $(HOME)

.PHONY: install uninstall update
