__load-common-nix-options

complete nixos-generate-config -x

complete nixos-generate-config -l force -d "Overwrite /etc/nixos/configuration.nix if it exists"
complete nixos-generate-config -l root -d "Directory to treat as root of filesystem" -Fr
complete nixos-generate-config -l dir -d "Directory to write configuration files to (Default /etc/nixos)" -Fr
complete nixos-generate-config -l no-filesystems -d "Omit file system information from hardware configuration"
complete nixos-generate-config -l show-hardware-config -d "Print hardware configuration to stdout without writing anything to disk"
complete nixos-generate-config -l kernel -xa "lts latest"
complete nixos-generate-config -l kernel -d "Choose kernel version (lts or latest)"
complete nixos-generate-config -l flake -d "Generate flake.nix"
