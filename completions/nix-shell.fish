__load-common-nix-options

complete nix-shell -x

complete nix-shell -l command -xa "(complete -C)"
complete nix-shell -l command -d "Run a command instead of starting an interactive shell"
complete nix-shell -l exclude -d "Do not build any dependencies which match this regex"
complete nix-shell -l pure -d "Clear the environment before starting the interactive shell"
complete nix-shell -l run -xa "(complete -C)"
complete nix-shell -l run -d "Run a command in a non-interactive shell instead of starting an interactive shell"
complete nix-shell -l attr -s A -xa "(_nix_complete_attr_paths)"
complete nix-shell -l attr -s A -d "setup a build shell for package"

__nix_boilerplate_opts nix-shell
__nix_common_opts nix-shell
__nix_dry_run nix-shell
# _nix_shell_opts nix-shell
_nix_path nix-shell
__nix_expr_opts nix-shell

complete nix-shell -l packages -s p -xa "(_nix_attr_paths \"import <nixpkgs>\")"
complete nix-shell -l packages -s p -d "run with packages from <nixpkgs> (override using -I)"
