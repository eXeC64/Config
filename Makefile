STOW = stow

PACKAGES = shell vim i3 kernel

install: $(PACKAGES)
		$(STOW) -S $^

uninstall: $(PACKAGES)
		$(STOW) -D $^

update: $(PACKAGES)
		$(STOW) -R $^

.PHONY: install uninstall update
