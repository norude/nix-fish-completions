__load-common-nix-options

complete nix-channel -x

complete nix-channel -l add -d "Subscribe to a channel"
complete nix-channel -l remove -xa "(nix-channel --list | string split ' ' -f1)"
complete nix-channel -l remove -d "Unsubscribe from a channel"
complete nix-channel -l list -d "List subscribed channels"
complete nix-channel -l update -xa "(nix-channel --list | string split ' ' -f1)"
complete nix-channel -l update -d "Update and activate channels"
complete nix-channel -l rollback -d "Revert the previous nix-channel --update"
