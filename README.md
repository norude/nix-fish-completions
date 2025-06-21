FISH Completions for Nix and NixOS
=================================
This project aims to provide a highly complete set of FISH completions for [Nix](https://nixos.org/nix/),
[NixOS](https://nixos.org/), [NixOps](http://nixos.org/nixops/), and the surrounding ecosystem.

It was initialy based on [nix-community/nix-zsh-completions](https://github.com/nix-community/nix-zsh-completions).

Installation
--------------------

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install norude/nix-fish-completions
```

If you want your prompt to be prefixed by `[nix-shell]` when you're in a nix-shell
add this to your fish.config AFTER your prompt's definition:

```fish
prompt_nix_shell_setup
```

