__load-common-nix-options

complete nix-copy-closure -l to -d "Copy the closure to the remote machine (default)"
complete nix-copy-closure -l from -d "Copy the closure from the remote machine"
complete nix-copy-closure -l sign -d "Cryptographically sign to allow sharing between untrusted users on trusted machines"
complete nix-copy-closure -l gzip -d "Enable compression of the SSH connection"
complete nix-copy-closure -l include-outputs -d "Also copy outputs of store derivations included in the closure"
complete nix-copy-closure -l use-substitutes -s s -d "Download files from the binary cache if possible"

complete nix-copy-closure -n __fish_use_subcommand -n "not string match -q '*@*' -- (commandline -cpt)" -xa "(__fish_complete_users)"
complete nix-copy-closure -n __fish_use_subcommand -n "string match -q '*@*' -- (commandline -cpt)" -xa "(__fish_complete_user_at_hosts)"

