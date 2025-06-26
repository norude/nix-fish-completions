__load-common-nix-options

complete nix-build -x

__nix_expr_opts nix-build
__nix_common_store_opts nix-build
complete nix-build -l attr -s A -xa "(_nix_complete_attr_paths)"
complete nix-build -l attr -s A -d "build a package from file (default: ./default.nix)"
complete nix-build -l check -d "Rebuild derivation"
complete nix-build -l drv-link -d "Add a symlink to the store derivation"
complete nix-build -l add-drv-link -d "Shorthand for --drv-link ./derivation"
complete nix-build -l no-out-link -d "Do not create a symlink to the output path"
complete nix-build -l out-link -s o -d "Name of the output symlink"

# TODO: Undocumented args to possibly add
# --add-root
# --check
# --quiet
# --command
# --exclude
# --pure
# --impure
# --packages,-p

__nix_boilerplate_opts nix-build
__nix_common_opts nix-build
__nix_dry_run nix-build
_nix_path nix-build
