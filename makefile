CD = $(PWD)
SUBLY=.sub/ly-dm
SUBDMENU=.sub/dmenu-wayland

build: install-ly install-dmenu config
	@echo "press MOD+C to reload sway"


# === CONFIG ===

config: ly-config dmenu-config sway-config
	@echo "replacing config..."
	@sudo cp init/.profile ~/.profile

dmenu-config: 
	@sudo cp 

ly-config:
	@sudo cp ly/config.ini /etc/ly/config.ini
	

sway-config: 
	@echo "setting up autostart sway..."
	@sudo cp -r sway/ ~/.config/sway/


# === INSTALL ===

install: install-apt install-ly install-dmenu

install-apt:
	@echo "install apt dependencies..."
	@cat apt-install.txt | xargs sudo apt -y install

install-dmenu: update-sub install-apt
	@echo "installing dmenu..."
	@cd $(SUBDMENU) && \
	mkdir build && \
	meson build && \
	ninja -C build && \
	sudo ninja -C build install && \
	cd $(PWD)

install-ly: update-sub install-apt
	@echo "installing ly..."
	@cd $(SUBLY) && \
	sudo make && \
	sudo make install && \
	sudo systemctl enable ly.service && \
	sudo systemctl disable getty@tty2.service && \
	cd $(PWD)


# === OTHER === 

update-sub:
	@echo "unpdate sub repo..."
	@git submodule update --init --recursive

uninstall:
	@echo "uninstalling..."

clean:
	@echo "cleaning"
	@cd $(SUBLY) && $(MAKE) clean
	@cd $(SUBDMENU) && rm -r build

