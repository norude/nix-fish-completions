__load-common-nix-options
complete nixos-rebuild -x

complete nixos-rebuild -n __fish_use_subcommand -a switch -d "Build, activate, and update boot default"
complete nixos-rebuild -n __fish_use_subcommand -a boot -d "Build and update boot default without activating"
complete nixos-rebuild -n __fish_use_subcommand -a test -d "Build and activate without updating boot default"
complete nixos-rebuild -n __fish_use_subcommand -a build -d "Build without activating or updating boot default"
complete nixos-rebuild -n __fish_use_subcommand -a dry-build -d "Show what store paths would be built or downloaded without building"
complete nixos-rebuild -n __fish_use_subcommand -a dry-activate -d "Build and show what changes would be performed by the activation"
complete nixos-rebuild -n __fish_use_subcommand -a build-vm -d "Create a script which starts a VM with the built configuration"
complete nixos-rebuild -n __fish_use_subcommand -a build-vm-with-bootloader -d "Like build-vm, but boot using regular boot loader"

__nix_common_nixos_rebuild nixos-rebuild
complete nixos-rebuild -l upgrade -d "Fetch the latest version of NixOS from the NixOS channel"
complete nixos-rebuild -l upgrade-all -d "Fetch the latest version of all channels"
complete nixos-rebuild -l install-bootloader -d "(Re)install bootloader on the configured device"
complete nixos-rebuild -l no-build-nix -d "Don't build Nix package manager]"
complete nixos-rebuild -l fast -d "Equivalent to --no-build-nix --show-trace"
complete nixos-rebuild -l rollback -d "Roll back to the previous configuration"
complete nixos-rebuild -l profile-name -s p -xa "(_nix_profiles)"
complete nixos-rebuild -l profile-name -s p -d "Profile to use to track current and previous system configurations"
