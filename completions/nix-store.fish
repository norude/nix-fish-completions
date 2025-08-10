__load-common-nix-options

complete nix-store -x

set --local options

function __nix_store_common_opts
    complete $argv -F
    __nix_repair $argv
    __nix_common_store_opts $argv
    __nix_common_nixos_rebuild $argv
    __nix_extra_build_opts $argv
end 


set --append options -l realise -s r 
__nix_store_common_opts nix-store -n "__fish_seen_argument -l realise -s r"
__nix_store_realise_opts nix-store -n "__fish_seen_argument -l realise -s r"

set --append options -l serve 
__nix_store_common_opts nix-store -n "__fish_seen_argument -l serve"
complete nix-store -n "__fish_seen_argument -l serve" -l write -d "allow writing to the nix store"

set --append options -l gc 
__nix_store_common_opts nix-store -n "__fish_seen_argument -l gc"
__nix_gc_common nix-store -n "__fish_seen_argument -l gc"
complete nix-store -n "__fish_seen_argument -l gc" -l max-freed -d "stop the gc after freeing n bytes"

set --append options -l delete 
__nix_store_common_opts nix-store -n "__fish_seen_argument -l delete"
complete nix-store -n "__fish_seen_argument -l delete" -l ignore-liveness -d "Ignore reachability from roots"


set --append options -l query -s q
complete nix-store -n "__fish_seen_argument -l query -s q" -l use-output -s u -d "Apply the query to the output path of any store derivations"
complete nix-store -n "__fish_seen_argument -l query -s q" -l force-realise -s f -d "Realise each argument to the query first"
complete nix-store -n "__fish_seen_argument -l query -s q" -l requisites -s R -d "Print the closure of the given store paths"
__nix_store_common_opts nix-store -n "__fish_seen_argument -l query -s q" -n "__fish_seen_argument -l requisites -s R"
complete nix-store -n "__fish_seen_argument -l query -s q" -n "__fish_seen_argument -l requisites -s R" -l include-outputs -d "Also include the output paths of store derivations"
complete nix-store -n "__fish_seen_argument -l query -s q" -l outputs -d "Print the output paths of the given store derivations"
complete nix-store -n "__fish_seen_argument -l query -s q" -l references -d "Print immediate dependencies of the given store paths"
complete nix-store -n "__fish_seen_argument -l query -s q" -l referrers -d "Print store paths which refer to these paths"
complete nix-store -n "__fish_seen_argument -l query -s q" -l referrers-closure -d "Print the closure under the referrers relation"
complete nix-store -n "__fish_seen_argument -l query -s q" -l deriver -d "Print the deriver of the store paths"
complete nix-store -n "__fish_seen_argument -l query -s q" -l graph -d "Print the references graph of the store paths in Graphviz format"
complete nix-store -n "__fish_seen_argument -l query -s q" -l tree -d "Print the references graph of the store paths as an ASCII tree" 
complete nix-store -n "__fish_seen_argument -l query -s q" -l binding -s b -d "Print the value of an attribute of the store derivations"
complete nix-store -n "__fish_seen_argument -l query -s q" -l hash -d "Print the SHA-256 hash of the contents of the store paths"
complete nix-store -n "__fish_seen_argument -l query -s q" -l size -d "Print the size in bytes of the contents of the store paths" 
complete nix-store -n "__fish_seen_argument -l query -s q" -l roots -d "Print the garbage collector roots that point to the store paths"
__nix_store_common_opts nix-store -n "__fish_seen_argument -l query -s q" -n "__fish_seen_argument -l outputs -l references -l referrers -l referrers-closure -l deriver -s d -l graph -l tree -l binding -s b -l hash -l size -l roots"


set --append options -l verify 
__nix_store_common_opts nix-store -n "__fish_seen_argument -l verify"
complete nix-store -n "__fish_seen_argument -l verify" -l check-contents -d "Compute and validate the SHA-256 hash of each store item"

set --append options -l add 
set --append options -l verify-path 
set --append options -l repair-path 
set --append options -l dump 
set --append options -l restore 
set --append options -l export 
set --append options -l read-log -s l 
set --append options -l print-env 
__nix_store_common_opts nix-store -n "__fish_seen_argument -l add -l verify-path -l repair-path -l dump -l restore -l export -l read-log -s l -l print-env"

set --append options -l dump-db 
set --append options -l load-db 
set --append options -l optimise 
set --append options -l query-failed-paths 
#nothing to complete
#
set --append options -l import 
set --append options -l clear-failed-paths 
set --append options -l generate-binary-cache-key
complete nix-store -n "__fish_seen_argument -l generate-binary-cache-key" -n "not __fish_use_subcommand" -F
__nix_store_common_opts nix-store -n "__fish_seen_argument -l import -l clear-failed-paths -l generate-binary-cache-key"

complete nix-store -n "not __fish_seen_argument $options" -l realise -s r -d "Build the specified store paths"
complete nix-store -n "not __fish_seen_argument $options" -l serve -d "provide access to the nix store over stdin/stdout"
complete nix-store -n "not __fish_seen_argument $options" -l gc -d "Perform garbage collection on the Nix store"
complete nix-store -n "not __fish_seen_argument $options" -l delete -d "Delete store paths from the Nix store if it is safe to do so"
complete nix-store -n "not __fish_seen_argument $options" -l query -s q -d "Display information about store paths"
complete nix-store -n "not __fish_seen_argument $options" -l add -d "Add paths to the Nix store"
complete nix-store -n "not __fish_seen_argument $options" -l verify -d "Verify the consistency of the Nix database and store"
complete nix-store -n "not __fish_seen_argument $options" -l verify-path -d "Compare the contents of each store path to the hashes stored in the database"
complete nix-store -n "not __fish_seen_argument $options" -l repair-path -d "Attempt to repair the specified paths by redownloading them"
complete nix-store -n "not __fish_seen_argument $options" -l dump -d "Produce a NAR file containing the contents of the given path"
complete nix-store -n "not __fish_seen_argument $options" -l restore -d "Unpack a NAR archive, read from stdin, to the given path"
complete nix-store -n "not __fish_seen_argument $options" -l export -d "Serialize the specified store paths to stdout in a format which can be imported"
complete nix-store -n "not __fish_seen_argument $options" -l import -d "Read searialized store paths from stdin and add them to the Nix store"
complete nix-store -n "not __fish_seen_argument $options" -l optimise -d "Find identical files in the Nix store and hardlink them together to reduce disk usage"
complete nix-store -n "not __fish_seen_argument $options" -l read-log -s l -d "Print the build log of the specified store paths"
complete nix-store -n "not __fish_seen_argument $options" -l dump-db -d "Dump Nix database to stdout"
complete nix-store -n "not __fish_seen_argument $options" -l load-db -d "Read a dump of the Nix database"
complete nix-store -n "not __fish_seen_argument $options" -l print-env -d "Print the environment of a derivation as shell code"
complete nix-store -n "not __fish_seen_argument $options" -l query-failed-paths -d "Print out store paths which failed to build"
complete nix-store -n "not __fish_seen_argument $options" -l clear-failed-paths -d "Clear the \"failed\" state of the given store path"
complete nix-store -n "not __fish_seen_argument $options" -l generate-binary-cache-key -d "generate an Ed25519 key pair to sign build outputs"

argparse --ignore-unknown 's/short=+' 'l/long=+' -- $options

complete nix-store -l help -xa (string join ' ' -- --$_flag_l)
__nix_boilerplate_opts nix-store
