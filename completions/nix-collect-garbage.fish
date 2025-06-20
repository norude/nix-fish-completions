__load-common-nix-options

complete nix-collect-garbage -x

complete nix-collect-garbage -l delete-old -s d -d "Delete all old generations of all profiles"
complete nix-collect-garbage -l delete-older-than -d "Delete generations older than the given time" # "Time such as 30d"

__nix_dry_run nix-collect-garbage
