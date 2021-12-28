## [installation of sway](https://wiki.archlinux.org/title/Sway)
```sh
sudo apt install sway xwayland
```
[Sway can be started by adding the following to your](https://wiki.archlinux.org/title/Sway#Automatically_on_TTY_login) `~/.profile`

```bash
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
```
copy default configuration from `/etc/sway/confg`

```sh
sudo cp /etc/sway/config ~/.config/sway/config
```
