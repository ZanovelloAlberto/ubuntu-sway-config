CD = $(PWD)




build: install-ly install-dmenu autostart-sway

autostart-sway: 
	@echo "setting up autostart sway..."
	@sudo cp -r sway/ ~/.config/sway/

install-apt:
	@echo "install apt dependencies..."
	@cat apt-install.txt | xargs sudo apt -y install

update-sub:
	@echo "unpdate sub repo..."
	@git submodule update --init --recursive

install-dmenu: update-sub install-apt
	@echo "installing dmenu..."
	@cd .sub/dmenu-wayland && \
	mkdir build && \
	meson build && \
	ninja -C build && \
	sudo ninja -C build install && \
	cd $(PWD)


install-ly: update-sub install-apt
	@echo "installing ly..."
	@cd .sub/ly-dm && \
	sudo make && \
	sudo make install && \
	sudo systemctl enable ly.service && \
	sudo systemctl disable getty@tty2.service && \
	cd $(PWD)


uninstall:
	@echo "uninstalling..."


clean:
	@echo "cleaning"
	@cd .sub/ly-dm && $(MAKE) clean
	@cd .sub/dmenu-wayland && rm -r build