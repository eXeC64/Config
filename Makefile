STOW = stow

PACKAGES = shell vim i3 scripts gdb weechat

install:
	sudo pacman -S --noconfirm stow zsh openssh xorg i3 alsa-utils pulseaudio htop chromium weechat thunderbird gvim slim rxvt-unicode wget rsync scrot unzip unrar evince ttf-dejavu ttf-freefont ttf-symbola ttf-inconsolata

config: $(PACKAGES)
		$(STOW) -S $^ -t $(HOME)

unconfig: $(PACKAGES)
		$(STOW) -D $^ -t $(HOME)

#Everyone loves newspeak.
upconfig: $(PACKAGES)
		$(STOW) -R $^ -t $(HOME)

.PHONY: install config unconfig upconfig 
