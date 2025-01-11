# ⭐ Dotfiles

![Fetch](./assets/fetch.png)

## Description

My dotfiles. See `Notes` for quirks.

## Installlation

Automation is done using `stow`. See provided `makefile` for details.

In project directory:

- `make` (re-)deploys the symlinks for files to `$HOME`.
- `make remove` removes the symlinks created by `make`.

> Note: if there are any conflicts e.g. the deployment of symlinks would
> overwrite files, which already exist, `stow` WILL fail. Resolve the
> conflicts manually if needed.

## Notes

### NeoVim

Inherits most of the configuration from `standalone/.vimrc`.

### Scripts

Has a bunch of custom scripts in `scripts/.scripts`, which are then used in:

- `config/.config/polybar/config.ini`.
- `config/.config/sxhkd/sxhkdrc`.

#### Polybar

1. `scripts/.scripts/window_monitor.sh`: show current focused window class OR
   alternative name, custom replacement for
   [MateoNitro550/xxxwindowPolybarModule](https://github.com/MateoNitro550/xxxwindowPolybarModule).
2. `scripts/.scripts/layout_monitor.sh`: show current layout.
3. `scripts/.scripts/volume_monitor.sh`: show current output audio volume,
   made using a customized fork (shows Bluetooth devices) of
   [marioortizmanero/polybar-pulseaudio-control](https://github.com/marioortizmanero/polybar-pulseaudio-control).
   See PR (still needs additional work/fork):
   [marioortizmanero/polybar-pulseaudio-control/pull/74](https://github.com/marioortizmanero/polybar-pulseaudio-control/pull/74).

#### Sxhkd

1. `scripts/.scripts/bluetoothctl_earphones_toggle.sh`: toggle Bluetooth
   earphones.
2. `scripts/.scripts/dunst_pause.sh`: pause `dunst` notifications.
3. `scripts/.scripts/ffmpeg_record_toggle.sh`: record screen with audio using
   `ffmpeg`.
4. `scripts/.scripts/kitty_float_toggle.sh`: toggle floating `kitty` terminal
   (**see demo below**).
5. `scripts/.scripts/screenkey_toggle.sh`: toggle `screenkey`.
6. `scripts/.scripts/wireguard_toggle.sh`: toggle Wireguard.

#### Kitty float toggle demo

Uses `bspc` interface in `bspwm` to spawn a terminal with a special window
class. Terminal then can be triggered to appear in the same state it was
on any desktop you want, preserving its geometry and all output.

![Kitty float toggle demo](./assets/kitty_float_toggle.gif)

### Xinitrc

Has a block, which handles (re-)attaching external keyboards smoothly, a
slight rewrite of a solution found here:
[How to set the keymap for keyboards that are plugged in later?](https://unix.stackexchange.com/questions/253489/how-to-set-the-keymap-for-keyboards-that-are-plugged-in-later)
