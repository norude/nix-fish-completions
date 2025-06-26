__load-common-nix-options

complete nix-instantiate -x

# --no-location: undocumented arg
# --repair: undocumented arg

__nix_boilerplate_opts nix-instantiate
__nix_common_opts nix-instantiate
__nix_common_store_opts nix-instantiate
__nix_expr_opts nix-instantiate
complete nix-instantiate -l attr -s A -d "build a .drv from file (default: ./default.nix)" -xa "(_nix_complete_attr_paths)"
complete nix-instantiate -l xml -d "Print output from --eval as XML"
complete nix-instantiate -l json -d "Print output from --eval as JSON"
complete nix-instantiate -l parse -d "Just parse the input files and print their abstract syntax trees"
complete nix-instantiate -l eval -d "Just parse and evaluate the input files, and print the resulting values"
complete nix-instantiate -l strict -d "Cause --eval to recursively evaluate list elements and attributes"
complete nix-instantiate -l read-write-mode -d "Perform evaluation in read/write mode"
complete nix-instantiate -l find-file -d "Look up the given files on Nix's search path"
_nix_path nix-instantiate
