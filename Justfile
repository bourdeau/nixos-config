# Hosts available for builds
hosts := "phantec phcorsair phzenbook"

# Default recipe: show available commands and hosts
default:
  @echo "Available commands:"
  @echo "  build <host>       - Build system for a given host"
  @echo "  boot <host>        - Build system for a given host, applied at next boot"
  @echo "  check <host>       - Dry-run build for a given host (simulate changes)"
  @echo "  clean              - Remove old generations, keep only the last 5"
  @echo "  gc                 - Garbage collect and optimise the nix store"
  @echo "  generations        - List all available system generations"
  @echo "  rollback           - Roll back to the previous generation"
  @echo "  test <host>        - Test configuration for a given host (temporary)"
  @echo "  update             - Update flake inputs"
  @echo
  @echo "Available hosts:"
  @echo "  {{hosts}}"

# Build system for a given host
build +host:
  git add -A
  sudo nixos-rebuild switch --flake .#{{host}}

# Rebuild system for a given host, applied at next boot
boot +host:
  sudo nixos-rebuild boot --flake .#{{host}}

# Build system for a given host, but only simulate the changes
check +host:
  sudo nixos-rebuild switch --flake .#{{host}} --dry-run

# Remove old generations, keep only the last 5
clean:
  sudo nix-collect-garbage --delete-older-than 7d
  sudo nix-env --delete-generations +5
  sudo nix-collect-garbage -d

# Garbage collect and optimise the nix store
gc:
  sudo nix-collect-garbage -d
  sudo nix-store --optimise

# List all available system generations
generations:
  sudo nix-env --list-generations

# Roll back to the previous generation
rollback:
  sudo nixos-rebuild switch --rollback

# Test configuration for a given host (temporary, not persisted)
test +host:
  sudo nixos-rebuild test --flake .#{{host}}

# Update flake inputs
update:
  nix flake update
