## Recovering a Broken NixOS Boot Configuration

1. Check Available Generations

```
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
ls -l /nix/var/nix/profiles/system-*
```

2. Manually Switch to a Previous Generation

Find the correct generation in /nix/var/nix/profiles/system-XX-link and run:
```
sudo /nix/store/<corresponding-nixos-system>/bin/switch-to-configuration boot
```

Then reboot:
```
sudo reboot
```

3. Fix the System Profile Symlink

If the system boots into the correct generation but nix-env --list-generations still shows an incorrect "current" version:
```
sudo rm /nix/var/nix/profiles/system
sudo ln -s /nix/var/nix/profiles/system-XX-link /nix/var/nix/profiles/system
```

(Replace XX with the correct generation number.)

4. Rebuild and Update the Bootloader

```
sudo nixos-rebuild boot
sudo nixos-rebuild switch
```

5. Verify the Current Generation

```
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
cat /run/current-system/system-version
```

6. Clean Up Old Generations

```
sudo nix-collect-garbage -d
```
