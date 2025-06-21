#!/usr/bin/env fish

if set -q _NIX_SHELL_COMPLETION_LOADED
    # No point in re-defining these functions each time we do a completion
    return 0
end

function __load-common-nix-options
    # this is located in functions/__load-common-nix-options.fish, so calling it will load this file
    # not sure if this is a good way of doing this, but it works
end

# Simple completion function to select a system
# List gathered from: https://github.com/NixOS/nixpkgs/blob/master/lib/platforms.nix
function _nix_systems
#     _values 'Systems' \
#         i686-linux x86_64-linux \
#         armv5tel-linux armv6l-linux armv7l-linux mips64el-linux \
#         x86_64-darwin \
#         i686-freebsd x86_64-freebsd \
#         i686-openbsd x86_64-openbsd \
#         i686-netbsd x86_64-netbsd \
#         i686-cygwin x86_64-cygwin
end

# Completion function to select an angle-bracket expression from the nix path
# Assumptions: No '=' in the actual path components in NIX_PATH
# TODO: Complete files in /some/path for expressions like <nixpkgs/pkgs/...>
# IMPROVEMENT: Remove '<nixos-config>' since that seems rather useless(?)
function _nix_shortcuts
    for p in $NIX_PATH
        if string match -q "*=*" -- $p
            echo -n "<$(string split -f1 -- "=" "$p")>"
            echo -e "\tShortcut"
        else
            for file in $p/*/default.nix
                if test -e "$file"
                    echo -n "<$(basename (dirname $file))>"
                    echo -e "\tShortcut"
                end
            end
        end
    end
end

function _nix_path
#   _alternative \
#     'nixpkgs:Nixpkgs:_nix_shortcuts' \
#     'path:File Path:_nix_complete_dotnix_files'
end

function _nix_complete_dotnix_files
    # WARN: __fish_complete_directories is not included in this function and should be done one level higher
    _nix_shortcuts
    echo -e "channel:\tChannel"
    echo -e "channel:nixos-13.10\tChannel"
    echo -e "channel:nixos-14.04\tChannel"
    echo -e "channel:nixos-14.04-small\tChannel"
    echo -e "channel:nixos-14.12\tChannel"
    echo -e "channel:nixos-14.12-small\tChannel"
    echo -e "channel:nixos-15.09\tChannel"
    echo -e "channel:nixos-15.09-small\tChannel"
    echo -e "channel:nixos-16.03\tChannel"
    echo -e "channel:nixos-16.03-small\tChannel"
    echo -e "channel:nixos-16.09\tChannel"
    echo -e "channel:nixos-16.09-small\tChannel"
    echo -e "channel:nixos-17.03\tChannel"
    echo -e "channel:nixos-17.03-small\tChannel"
    echo -e "channel:nixos-17.09\tChannel"
    echo -e "channel:nixos-17.09-small\tChannel"
    echo -e "channel:nixos-18.03\tChannel"
    echo -e "channel:nixos-18.03-small\tChannel"
    echo -e "channel:nixos-18.09\tChannel"
    echo -e "channel:nixos-18.09-small\tChannel"
    echo -e "channel:nixos-19.03\tChannel"
    echo -e "channel:nixos-19.03-small\tChannel"
    echo -e "channel:nixos-19.09\tChannel"
    echo -e "channel:nixos-19.09-small\tChannel"
    echo -e "channel:nixos-20.03\tChannel"
    echo -e "channel:nixos-20.03-small\tChannel"
    echo -e "channel:nixos-20.09\tChannel"
    echo -e "channel:nixos-20.09-small\tChannel"
    echo -e "channel:nixos-21.05\tChannel"
    echo -e "channel:nixos-21.05-small\tChannel"
    echo -e "channel:nixos-21.11\tChannel"
    echo -e "channel:nixos-21.11-small\tChannel"
    echo -e "channel:nixos-22.05\tChannel"
    echo -e "channel:nixos-22.05-small\tChannel"
    echo -e "channel:nixos-22.11\tChannel"
    echo -e "channel:nixos-22.11-small\tChannel"
    echo -e "channel:nixos-23.05\tChannel"
    echo -e "channel:nixos-23.05-small\tChannel"
    echo -e "channel:nixos-23.11\tChannel"
    echo -e "channel:nixos-23.11-small\tChannel"
    echo -e "channel:nixos-24.05\tChannel"
    echo -e "channel:nixos-24.05-small\tChannel"
    echo -e "channel:nixos-24.11\tChannel"
    echo -e "channel:nixos-24.11-small\tChannel"
    echo -e "channel:nixos-25.05\tChannel"
    echo -e "channel:nixos-25.05-small\tChannel"
    echo -e "channel:nixos-unstable\tChannel"
    echo -e "channel:nixos-unstable-small\tChannel"
    echo -e "channel:nixpkgs-unstable\tChannel"
    echo -e "https://\tUrl"
    echo -e "http://\tUrl"
    set -f x *.nix
    string join -- \n $x(echo -e "\tLocal file")
end  # see: https://channels.nixos.org/

function _nix_complete_includes
    function __nix_get_path_names
        for p in $NIX_PATH
            if string match -q "*=*" -- $p 
                echo (string split -f1 -- "=" "$p")
            end
        end
    end
    complete $argv -kxa "(__fish_complete_directories)"
    complete -n "not string match -q '*=*' -- (commandline -cpt) " $argv -kxa "(__nix_get_path_names)="
    complete -n "string match -q '*=*' -- (commandline -cpt) " $argv -kxa "(commandline -cpt|string replace -r '=[^=]*\$' '')=(_nix_complete_dotnix_files)"
    return
end

function _nix_generations
#     # List of package names with version numbers stripped
#     setopt extendedglob
#     local -a generations=(${${${(f)"$(nix-env --list-generations)"}##  #}/  /:})
#     _describe -V "Nix Generations" generations
end

function _nix_installed_packages
#     # List of package names with version numbers stripped
#     # with the alternative to specify store paths
#     local extra_help=$1
#     local prefix='-P ./'
#     local current_word=$words[$CURRENT]
#     # When referencing an absolute path we can't prefix with ./
#     if [[ -z ${current_word:##(/*|\~/*)} && -n $current_word ]]; then
#         prefix=""
#     fi
#     local -a packages=(${${(f)"$(nix-env -q)"}%%-[0-9]*})

#     _alternative \
#         "package:packages:_values 'Installed package $extra_help' $packages" \
#         "file:Store path to package:_files ${prefix}"
end


# Generate nix code creating the default expression used by 'nix-env -iA'
function _nix_gen_defexpr
#     setopt local_options null_glob
#     local -A result # name -> path map

#     # Search depth first for directories containing 'default.nix'
#     # nix-env -iA prioritize the user's channels in case of name collision
#     # Not sure how collisions in user-created directories are resolved.
#     local -aU initialQueue=($1/channels $1/channels_root $1/*)
#     local -a queue=($initialQueue)

#     while [[ ${#queue} > 0 ]]; do
#         local current=$queue[1]
#         shift queue
#         if [[ -e $current/default.nix ]]; then
#             local name=$(basename $current)
#             if [[ -z $result[$name] ]]; then
#                 result[$name]=$current
#             fi
#         else
#             queue=($current/* $queue)
#         fi
#     done

#     local nix_expr="{\n"
#     for name expr_path in ${(kv)result}; do
#         nix_expr+="${name} = import ${expr_path};"
#         nix_expr+="\n"
#     done
#     nix_expr+="}"

#     echo $nix_expr
end


# Complete attribute names using $1 as the toplevel expression NB: If calling
# this function from an action spec you need to prefix it with a space so that
# eg. _arguments won't pass it options which it doesn't expect, ie:
#     `: _nix_attr_paths`
function _nix_attr_paths

#     local cur=${${words[$CURRENT]#(\'|\")}%(\'|\")}

#     # Starting with '.' causes _sep_parts to complain, so exit early.
#     # This also guards against error output when completion './files' with nix.
#     if [[ $cur == .* ]]; then
#         return
#     fi

#     local defexpr=$1
#     local attr_path=""
#     if [[ $cur == *.* ]]; then
#         attr_path=${cur%.*}
#     fi

#     # attr1.attr3 -> ("attr1" "attr2")
#     local -a paths=(${(s,.,)attr_path})
#     # Add quotes in a second step to avoid ("") when empty
#     paths=(${${paths/%/\"}/#/\"})

#     # Auto call any functions in the attribute path. This isn't a language
#     # feature, but done by nix when passing attributes on the command line.
#     local -a result
#     result=($(_nix_eval_stdin <<NIX_FILE
#         let
#           autocall = setOrLambda:
#               if builtins.isFunction setOrLambda then
#                  setOrLambda {}
#               else
#                  setOrLambda;

#           top = autocall ($defexpr);
#           names = [ ${paths[*]} ];

#           # Returns attr.name calling it if it's a function
#           reducer = set: name:
#               autocall (builtins.getAttr name set);
#           result = builtins.foldl' reducer top names; #'
#         in
#           if builtins.isAttrs result then
#             builtins.attrNames result
#           else
#             ""
# NIX_FILE
#     ))

#     # If the eval failed return the error message
#     if [[ $? > 0 ]]; then
#         _message "Eval failed, can't complete (an URL might not be cached):
# $result"
#         return 1
#     fi

#     local -a prefix=()
#     if [[ -n $attr_path ]]; then
#         for i in ${=attr_path//./ }; do
#             prefix+=("($i)" .)
#         done
#     fi

#     local package=""
#     _wanted package package "Attribute path" \
#             _sep_parts $prefix result \.
#     return $?
end

function _nix_eval_stdin
#     setopt local_options pipefail
#     # Build up a modified NIX_PATH using -I and --include
#     local i override=""
#     for ((i=1; i < ${#words[*]}; i++)); do
#         case "${words[i]}" in
#             -I|--include)
#                 override+=${override:+:}${words[$((i+1))]}
#                 ;;
#         esac
#     done
#     override+=${override:+:}${NIX_PATH}

#     # Resolve channel: syntax
#     while [[ "$override" == *(=|:)channel:* ]]; do
#         local channel=${override#*channel:}
#         channel="channel:"${channel%%:*}
#         local url="https://nixos.org/channels/"${channel:8}"/nixexprs.tar.xz"
#         # Replace the channel with its url
#         override=${override/"$channel"/"$url"}
#     done

#     # Resolve any url to a cache, else we might trigger a blocking download
#     while [[ "$override" == *https://* ]]; do
#         # Find the first url
#         local url=${override#*https://}
#         # Strip everything starting with the first colon
#         url="https://"${url%%:*}
#         local cache=$(_nix_resolve_url "$url")
#         # Replace the url with the cache
#         override=${override/"$url"/"$cache"}
#     done

#     NIX_PATH=$override nix-instantiate --eval - 2>/dev/null | tr '[]"' ' '
#     return $?
end


# Generate the top level expression in all the various ways the different
# commands expects it to be built. Then generate completions by calling
# _nix_attr_paths $defexpr
function _nix_complete_attr_paths

#     local defexpr=""
#     local file=$(_nix_get_file_arg)
#     if [[ "$file" ]]; then
#         # Extract --arg and --argstr into $args
#         local i=1 args="" name="" value=""
#         for ((i=1; i < ${#words[*]}; i++)); do
#             case "${words[$i]}" in
#                 --arg)
#                     name=${(Q)words[$((i+1))]}
#                     value=${(Q)words[$((i+2))]}
#                     args+="$name = $value;"
#                     i=$((i+2))
#                     ;;
#                 --argstr)
#                     name=${(Q)words[$((i+1))]}
#                     value=${(Q)words[$((i+2))]}
#                     args+="$name = \"$value\";"
#                     i=$((i+2))
#                     ;;
#             esac
#         done
#         args=${args:+{$args}}

#         local opt
#         defexpr="import $file $args"
#         for opt in $words; do
#             case $opt in
#                 --expr|-[^-]#E[^-]#)
#                     defexpr="($file) $args"
#                     break
#                     ;;
#             esac
#         done
#     else
#         if [[ $service == nix-env ]]; then
#             defexpr=$(_nix_gen_defexpr ~/.nix-defexpr)

#         elif [[ $service == nix ]]; then
#             # Extract the channels from NIX_PATH and -I/--include
#             local -a channels=(${(s.:.)NIX_PATH})
#             # Add -I/--include afterwards, so they will shadow the NIX_PATH
#             channels+=(${(s.:.)opt_args[-I]})
#             channels+=(${(s.:.)opt_args[--include]})

#             # Add the names in an associative array to avoid duplicates
#             local -A names
#             local channel name
#             for channel in $channels; do
#                 name=${channel%%=*}
#                 nix_path=${channel#*=}
#                 if [[ $name != $channel ]]; then
#                     # Only add paths with a name, not sure how they work
#                     names[$name]=1
#                 fi
#             done

#             defexpr=$'{ '
#             for name in ${(@k)names}; do
#                 # nixos-config isn't useful or possible to complete
#                 [[ $name == nixos-config ]] && continue
#                 defexpr+="$name = import <${name}>; "
#             done
#             defexpr+=' }'
#         fi
#     fi

#     if [[ $defexpr ]]; then
#         _nix_attr_paths $defexpr
#     fi
end

function _nix_resolve_url
#     local url=$1
#     local version="$($service --version)"
#     local input
#     if [[ "${version##* }" == 1.11.* ]]; then
#         # works for nix 1.11
#         input="$url"
#     else
#         # works for nix 1.12
#         input="${url##*/}\0$url"
#     fi
#     local sha
#     sha=$(nix-hash --flat --base32 --type sha256 <(printf "$input"))
#     local cache=${XDG_CACHE_HOME:-~/.cache}/nix/tarballs
#     local link="$cache"/"$sha"-file
#     if [[ -e "$link" ]]; then
#         echo "$cache/$(basename $(readlink $link))-unpacked"
#     fi
end

function _nix_get_file_arg

#     local file=""
#     if [[ "$service" == (nix-env|nix) ]]; then
#         local i
#         # Extract the last seen -f/--file argument
#         for ((i=1; i < ${#words[*]}; i++)); do
#             case "${words[i]}" in
#                 --file|-f)
#                     file=${words[$((i+1))]}
#                     ;;
#                 -f\.)
#                     # -f. is accepted shorthand for -f .
#                     file=.
#                     ;;
#             esac
#         done
#     elif [[ $line ]]; then
#         file=$line[1]
#     elif [[ -e shell.nix && $service == nix-shell ]]; then
#         file=shell.nix
#     elif [[ -e default.nix ]]; then
#         file=default.nix
#     fi

#     # Remove one level of shell quoting to make sure we see the same value as
#     # the nix-* program will see.
#     # ($opt_args and $line contain the verbatim string:
#     #  eg. given `nix-shell '<nixpkgs>' -A ` $line[1] will be `'<nixpkgs>'` while
#     #  nix-shell will see `<nixpkgs>`)
#     file=${(Q)file}

#     if [[ "file" ]]; then
#         # Expand channel: syntax
#         if [[ "$file" == channel:* ]]; then
#             file="https://nixos.org/channels/"${file:8}"/nixexprs.tar.xz"
#         fi

#         if [[ -e $file ]]; then
#             # If the path exist use the absolute path to make sure import will
#             # accept it.
#             # (Otherwise the path is likely a <nixpkgs> notation)
#             file=${file:a}
#         elif [[ "$file" == https://* ]]; then
#             file=$(_nix_resolve_url $file)
#         fi
#     fi
#     print -n -- $file
end

function _nix_complete_function_arg
#     local file=$(_nix_get_file_arg)
#     local func=${file:+import $file} opt
#     local i exclude=""
#     for ((i=1; i < ${#words}; i++)); do
#         case "${words[$i]}" in
#             --expr|-[^-]#E[^-]#)
#                 func="$file"
#                 ;;
#             --arg|--argstr)
#                 # Don't add the name we're currently typing
#                 [[ $i == $((CURRENT - 1)) ]] && continue
#                 exclude+=${exclude:+|}${words[$((i+1))]}
#                 ;;
#         esac
#     done
#     if [[ ! $func ]]; then
#         return
#     fi
#     local -a names
#     names=($(_nix_eval_stdin 2>&1 <<NIX_FILE
#              if builtins.typeOf ($func) == "lambda" then
#                 builtins.attrNames (builtins.functionArgs ($func))
#              else
#                  ""
# NIX_FILE
#                     ))
#     if [[ $? > 0 ]]; then
#         _message "Eval failed, can't complete (an URL might not be cached):
# $names"
#         return 1
#     fi
#     names=(${names:#(${~exclude})})
#     [[ "$names" ]] && _values "Argument name" $names
end

function _nix_profiles
    set -f prefix "/nix/var/nix/profiles/"
    set -f cur (commandline -cpt)
    if test -n "$cur"
        set -f prefix $cur
    end
    __fish_complete_directories $prefix
end

# Either true or false: useful for completing many Nix options
function _nix_options_bool
#     _values true false
end

# FIXME: This doesn't work even in zsh and so I won't port it to fish. See https://github.com/nix-community/nix-zsh-completions/issues/23#issuecomment-2992187045
function _nix_options
#     # Complete nix options with descriptions
#     local -a nix_options
#     # Strip the header line, remove leading spaces and replace separating
#     # whitespace with ':'
#     nix_options=(${${${${(f)"$(nix --help-config)"}:1:-1}/#  /}/  ##/:})
#                    _describe -t nix_options "Option" nix_options
end
# FIXME: same as the previous
function _nix_options_value
#     # Print the description of the option we're setting
#     local OPTION=$words[$(($CURRENT - 1))]
#     # Remove lines not starting with " $OPTION " and strip eveything up to the
#     # last two consecutive spaces
#     local description=${${${(f)"$(nix --help-config)"}:#^(  $OPTION *)}/*  /}
#     local -a values=()
#     case "$description" in
#         Whether*)
#             _values $description true false
#         ;;
#         *)
#             _path_files
#         ;;
#     esac
end



function _nix_run_command_names
#     local cmd chan

#     if (( ${+commands[sqlite3]} )); then
#         # Extract the channels from NIX_PATH and -I/--include
#         # Add -I/--include afterwards, so they will shadow the NIX_PATH
#         local -a nix_path=(
#             ${(s.:.)NIX_PATH}
#             ${(s.:.)opt_args[-I]}
#             ${(s.:.)opt_args[--include]}
#         )

#         # channels: key - channel name, value - path to channel
#         local -A channels
#         for chan in $nix_path; do
#             if [[ $chan = *=* ]]; then
#                 # name=path
#                 channels[${chan%%=*}]=${chan#*=}
#             else
#                 # path to directory with channels
#                 for chan in $chan/*(-/); do
#                     channels[$chan:t]=$chan
#                 done
#             fi
#         done

#         # pkg_cmds is list of commands inside packages
#         # This is an associative array to avoid duplicates.
#         local -A pkg_cmds
#         for chan in ${(k)channels}; do
#             # Extract args with prefix "$chan."
#             local -a pkgs=( "${${(M)words[@]:#"$chan".*}[@]##"$chan".}" )
#             (( ${#pkgs} )) || continue

#             local db=${channels[$chan]}/programs.sqlite
#             [ -f "$db" ] || continue

#             pkgs=( "'${^pkgs[@]//\'/''}'" ) # SQL-quote
#             local query="SELECT name FROM programs WHERE package IN (${(j:,:)pkgs})"

#             for cmd in $(sqlite3 "$db" "$query"); do
#                 pkg_cmds[$cmd]=
#             done
#         done

#         compadd -X 'Package commands' -- ${(k)pkg_cmds}
#     fi

#     _command_names -e -X 'All commands'
end

# ## Common options

# Used in: nix-build, nix-env, nix-instantiate, nix-shell, nixops
function __nix_boilerplate_opts
#     '(- *)--help[Print help message and exit]'
#     '(- *)--version[Print version number and exit]'
end

# Used in: nix-collect-garbage, nix-env, nix-store, nixops
function __nix_dry_run
    complete $argv -l dry-run -d "Show what would be done without doing it"
end
# Used in: nix-collect-garbage, nix-store
function __nix_gc_common
#     '(- --print* --delete)--print-roots[Print roots used by garbage collector]'
#     '(- --print* --delete)--print-live[Print store paths reachable from roots]'
#     '(- --print* --delete)--print-dead[Print store paths not reachable from roots]'
#     '(- --print* --delete)--delete[Garbage collect all dead paths from the store]'
end

# Used in: nixos-install, nix_common_opts
function __nix_search_path_args
    _nix_complete_includes $argv -s I
    complete $argv -s I -d "add a path to the list of locations used to look up <...> file names"
end

function __nix_repair
    complete $argv -l repair -d "Fix corrupted or missing store paths by redownloading or rebuilding"
end

function __nix_expr_opts
    complete $argv -l expr -s E -d "interpret command line args as Nix expressions"
end

# Misc Nix options accepted by nixos-rebuild
function __nix_common_nixos_rebuild
    __nix_search_path_args $argv
    __nix_repair $argv
    complete $argv -l verbose -s v -d "Increase verbosity of diagnostic messages"
    complete $argv -l no-build-output -s Q -d "silence output to stdout and stderr"
    complete $argv -l max-jobs -s j -d "max number of build jobs in parallel"
    complete $argv -l cores -d "threads per job (e.g. -j argument to make)"
    complete $argv -l keep-going -s k -d "keep going until all builds are finished"
    complete $argv -l keep-failed -s K -d "keep failed builds (usually in /tmp)"
    complete $argv -l fallback -d "If binary download fails, fall back on building from source"
    complete $argv -l show-trace -d "Print stack trace of evaluation errors"
    complete $argv -l option -d "set Nix configuration option" -xa "(_nix_options) (_nix_options_value)"
end

function __nix_common_nixos_build_vms
#     '*--option[set Nix configuration option]:options:_nix_options:value:_nix_options_value'
end

function __nix_common_store_opts
#     '--add-root[register result as a root of the garbage collector]:path (Hint /nix/var/nix/gcroots):_path_files -/'
#     '--indirect[store gc root outside GC roots directory]'
end

# Used in: nix-build, nix-env, nix-instantiate, nix-shell and nix-store
function __nix_extra_build_opts
#     '--max-silent-time[max seconds without getting stdout/err from builder]:Seconds:'
#     '--timeout[max seconds builders should run]:seconds:'
#     '--readonly-mode[do not open Nix database]'
#     '--log-format[configure how output is formatted]:output format:((pretty\:"Default" escapes\:"Indicate nesting with escape codes" flat\:"Remove all nesting"))'
end

# Used in: nix-build, nix-env, nix-instantiate, nix-shell
function __nix_common_opts
#     $__nix_common_nixos_rebuild
#     $__nix_args_opts
#     $__nix_extra_build_opts
#     '*--include[add a path to the list of locations used to look up <...> file names]:include path:_nix_complete_includes'
#     '*--arg[argument to pass to the Nix function]:Name:_nix_complete_function_arg:Value: '
#     '*--argstr[pass a string]:Name:_nix_complete_function_arg:String: '
end

# Options for nix-store --realise, used by nix-build
function __nix_store_realise_opts
#     $__nix_dry_run
#     '--check[rebuild and see if output is deterministic]'
end

set _NIX_SHELL_COMPLETION_LOADED 1
