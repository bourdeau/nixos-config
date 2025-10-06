# Install on a new machine

If you try to install my config by running a command like

```
sudo nixos-rebuild --flake github:bourdeau/nios-config#phantec
```

**It won’t work**, as we most likely don’t have the same hardware. You also (hopefully) don’t have my GPG private key, so the secret manager (SOPS) won’t be able to decrypt the secrets either.

But if you’d like to use my configuration, here are the steps to follow:

```
git clone https://github.com/bourdeau/nixos-config.git ~
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/phantec/
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -s ~/nixos-config/ /etc/nixos
sudo nixos-rebuild switch --flake .#phantec
```
