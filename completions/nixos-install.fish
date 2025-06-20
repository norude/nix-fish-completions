__load-common-nix-options
complete nixos-install -x

__nix_search_path_args nixos-install
complete nixos-install -l root -d "Treat the given directory as the root of the NixOS installation" -xa "(__fish_complete_directories (commandline -cpt) 'Installation Root')"
complete nixos-install -l show-trace -d "Print a stack trace in case of evaluation errors"
complete nixos-install -l chroot -d "Chroot into given installation"
