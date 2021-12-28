NAME = ly
CD = $(PWD)

install: install-ly install-dmenu 
install-apt:
	@echo "install apt dependencies"
	cat apt-install.txt | xargs sudo apt -y install

update-sub:
	@echo "unpdate sub repo"
	@git submodule update --init --recursive

install-dmenu: update-sub install-apt
	@echo "installing dmenu"
	@cd .sub/dmenu-wayland && \
	mkdir build && \
	meson build && \
	ninja -C build && \
	sudo ninja -C build install && \
	cd $(PWD)


install-ly: update-sub install-apt
	@echo "installing ly"
	@cd .sub/ly-dm && \
	sudo make && \
	sudo make install && \
	sudo systemctl enable ly.service && \
	sudo systemctl disable getty@tty2.service && \
	cd $(PWD)


uninstall:
	@echo "uninstalling"


clean:
	@echo "cleaning"
	@rm -rf $(BIND) $(OBJD) valgrind.log
	@(cd $(SUBD)/termbox_next && $(MAKE) clean)