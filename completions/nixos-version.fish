#compdef nixos-version
#autoload
complete nixos-version -f

complete nixos-version -l "hash" -l "revision" -d "Show the full SHA1 hash of the Git commit from which this configuration was built."
complete nixos-version -l "configuration-revision" -d "Show the configuration revision if available."
complete nixos-version -l "json" -d "Print a JSON representation of the versions of NixOS and the top-level configuration flake."
