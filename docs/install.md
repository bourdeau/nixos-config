# Install on a new machine

If you try to install my config by running a command like

```
sudo nixos-rebuild --flake github:bourdeau/nios-config#phantec
```
**it will not work** as we quite likely don't have the same hardware.

But if you want to use my config here are the steps to follow:

```
git clone https://github.com/bourdeau/nixos-config.git ~
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/phantec/
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -s ~/nixos-config/ /etc/nixos
sudo nixos-rebuild switch --flake .#phantec
```
