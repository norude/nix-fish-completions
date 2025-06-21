__load-common-nix-options

complete nixos-build-vms -x

__nix_common_nixos_build_vms nixos-build-vms
complete nixos-build-vms -l show-trace -d "Show a trace of the output"
complete nixos-build-vms -l no-out-link -d "Do not create a 'result' symlink"
complete nixos-build-vms -l help -d "Show help"

complete nixos-build-vms -kxa "(__fish_complete_directories)"
complete nixos-build-vms -kxa "(_nix_complete_dotnix_files)"
