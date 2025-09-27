# Fedora Cinnamon

## [Dynamic Desktop Wallpaper](https://cinnamon-spices.linuxmint.com/extensions/view/97)

## Configure Flatpak repository

```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
## Desktop Scaling

1. right-click desktop
2. display
3. enable fractional scaling on settings
4. change scaling to 125% on layout

## Disable Desktop Icons

1. right-click desktop
2. customize
3. desktop settings
4. change desktop layout to "No desktop icons"

## [Dropbox](https://www.dropbox.com/install-linux)

```
cd ~
ln -s Dropbox/__documents__ Documents
ln -s Dropbox/__desktop__ Desktop
ln -s Dropbox/__phone__ Phone
```

## [Onebox](https://github.com/abraunegg/onedrive/tree/master)

```
sudo dnf install onedrive
```

Create config file:
```
# $HOME/.config/onedrive/config
skip_dir = "Attachments|backup|Desktop|Documentos|Pictures"
```

Enable `systemd` service

```
systemctl --user enable onedrive.service
systemctl --user start onedrive.service
```

## Desktop Bottom Bar

1. right-click bar
2. panel settings
3. change auto-hide panel to "Intelligently hide panel"

## Nvim/Vim

1. **Nvim settings**: [`$HOME/.config/nvim/init.vim`](init.vim)

2. Set nvim default editor and remove vim/nano

```
sudo dnf remove vim-common vim-data vim-enhanced vim-filesystem vim-minimal vim-powerline nano-default-editor
sudo dnf install nvim -y
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 99
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 99
```

3. Copy nvim settings to be system wide
```
sudo cp $HOME/.config/nvim/init.vim /etc/xdg/nvim/init.vim
```

## Text Editor (Xed)

Change theme to Oblivion theme.

## Gnome Terminal

**Note on copy file content**: `xsel -i --clipboard`

1. Disable menu bar
2. Disable shortcut
3. Change scheme and pallete to Tango
4. Disable scrollbar
5. Limit scroll to 10000
6. Set 120x40

**Colors**: using neovim theme color scheme

> List colors `for i in {0..255}; do printf "\x1b[38;5;${i}mcolor${i} - ██████████\n"; done`

* colors.primary
    * background        = "#14161b"
    * foreground        = "#E0E2EA"
    * dim_foreground    = "#C4C6CD"
    * bright_foreground = "#E0E2EA"
* colors.normal
    * black   = "#2c2e33"
    * red     = "#E5ADB9"
    * green   = "#A2DFC0"
    * yellow  = "#E3CA85"
    * blue    = "#95C5E5"
    * magenta = "#E5B6E6"
    * cyan    = "#7EDFDE"
    * white   = "#C4C6CD"
* colors.bright
    * black   = "#4f5258"
    * red     = "#FFC0B9"
    * green   = "#B4F6C0"
    * yellow  = "#FCE094"
    * blue    = "#A6DBFF"
    * magenta = "#FFCAFF"
    * cyan    = "#8CF8F7"
    * white   = "#9b9ea4"

## Tmux

1. **Settings**: [`$HOME/.config/tmux/tmux.conf`](tmux.conf)
2. Start a tmux session on bash login if no session exists.
    * [`$HOME/.bashrc.d/tmux.bash`](tmux.bash)

## Bashrc
**Settings**: [`$HOME/.bashrc`](bashrc)

## Start Windows from Command Line

```
ln -sf [`$PWD/start_windows`](start_windows) /usr/local/bin
```

## Grub HiDPI

1. Edit as root (not sudo)

```
# /etc/default/grub
#GRUB_TERMINAL_OUTPUT="console"
GRUB_TERMINAL_OUTPUT="gfxterm"
GRUB_GFXMODE=1920x1080
GRUB_GFXPAYLOAD_LINUX=keep
```

2. Update grup image

```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

## Bluetooth 

1. Enable fast connect

```
# /etc/bluetooth/main.conf
FastConnectable = true
ReconnectAttempts=7 # set the value to whatever values that you want
ReconnectIntervals=1,2,3   
```

2. Enable bluetooth during boot

```
# /etc/dracut.conf.d/bluetooth.conf
add_dracutmodules+=" bluetooth "
```

3. Run:
```
dracut --regenerate-all --force
```

## Random Network MAC 

**Settings**: [`/etc/NetworkManager/conf.d`](wifi_rand_mac.conf)

Restart NetworkManager:

```
systemctl restart NetworkManager
```

## Users privileges

* `visudo` and edit it to `NOPASSWD` on wheel group
* edit root bashrc: `export EDITOR=/usr/bin/vim` and `export VISUAL=/usr/bin/vim`

## System Auto Update

> **Note for debugging**:
> 
> ```
> sudo anacron -f -n -d
> journalctl -b -f --no-pager --catalog | grep anacron
> ```

**Settings**: [`/etc/cron.daily/system-update`](system-update)

## Unused Apps

```
sudo dnf remove hexchat firefox* pidgin thunderbird xawtv xfburn rhythmbox mpv nvidia-gpu-firmware* amd-*
```
