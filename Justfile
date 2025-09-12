hosts := "phantec phcorsair phzenbook"

build +host:
  sudo nixos-rebuild switch --flake .#{{host}}

clean:
  sudo nix-collect-garbage --delete-older-than 7d
  sudo nix-env --delete-generations +5
  sudo nix-collect-garbage -d
