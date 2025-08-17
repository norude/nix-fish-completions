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
    complete $argv -kxa "(__fish_complete_directories)"
    complete $argv -kxa "(_nix_complete_dotnix_files)"
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

    set -l result_keys
    set -l result_values
    # Search depth first for directories containing 'default.nix'
    # nix-env -iA prioritize the user's channels in case of name collision
    # Not sure how collisions in user-created directories are resolved.
    set -l queue $argv[1]/channels $argv[1]/channels_root $argv[1]/*
    set queue (string join \n -- $queue | sort -u)

    while test (count $queue) -gt 0
        set -l current $queue[1]
        set queue queue[2..]
        if test -e "$current/default.nix"
            set -l name (basename "$current")
            if contains -- $name $result_keys
                set -p queue $current/*
            else
                set -a result_values "$current"
                set -a result_keys "$name"
            end
        end
    end

    set -l nix_expr "{"
    for i in seq (count $result_keys)
        set -a nix_expr "$result_keys[$i] = import $result_values[$i];"
    end
    set -a nix_expr "}"
    string join \n -- nix_expr
end


# Complete attribute names using $1 as the toplevel expression NB: If calling
# this function from an action spec you need to prefix it with a space so that
# eg. _arguments won't pass it options which it doesn't expect, ie:
#     `: _nix_attr_paths`
function _nix_attr_paths
    set -l cur (string unescape -- (commandline -ptc))

    set -l defexpr $argv[1]
    set -l attr_path ""
    if string match -q '*.*' -- $cur
        set attr_path (string replace -r '\.[^.]*$' '' -- $cur)
    end
    set -l paths (string split -n '.' -- $attr_path)
    # Avoid ("") when empty
    set -l paths (for p in $paths; echo \"$p\"; end)

    # Auto call any functions in the attribute path. This isn't a language
    # feature, but done by nix when passing attributes on the command line.
    set -l get_attrs_expression "let"
    set -a get_attrs_expression "autocall = setOrLambda:"
    set -a get_attrs_expression "if builtins.isFunction setOrLambda then"
    set -a get_attrs_expression "setOrLambda {}"
    set -a get_attrs_expression "else"
    set -a get_attrs_expression "setOrLambda;"
    set -a get_attrs_expression "top = autocall ($defexpr);"
    set -a get_attrs_expression "names = [ $(string join " " -- $paths) ];"
    # Returns attr.name calling it if it's a function
    set -a get_attrs_expression "reducer = set: name:"
    set -a get_attrs_expression "autocall (builtins.getAttr name set);"
    set -a get_attrs_expression "result = builtins.foldl' reducer top names; #'"
    set -a get_attrs_expression "in"
    set -a get_attrs_expression "if builtins.isAttrs result then"
    set -a get_attrs_expression "builtins.attrNames result"
    set -a get_attrs_expression "else"
    set -a get_attrs_expression "\"\""
    set -l result (string join \n -- $get_attrs_expression | _nix_eval_stdin 2>&1)
    if test $status -gt 0
        # _message "Eval failed, can't complete (an URL might not be cached):\n$result"
        return 1
    end
    set -l prefix (string split -n '.' -- "$attr_path" | string join "." ) # Remove double dots
    if test -n "$prefix"
        set prefix "$prefix."
    end

    for r in $result
        echo "$prefix$r"
    end
end

function _nix_eval_stdin
    set -l words (commandline -poc)
    # Build up a modified NIX_PATH using -I and --include
    set -l override
    for i in (seq (count $words))
        switch "$words[$i]"
            case "--include" "-I"
                set -a override "$words[$(math $i + 1)]"
        end
    end
    set -a override $NIX_PATH

    # Resolve channel: syntax
    for i in (seq (count $override))
        set -l channel (string match -gr "channel:(.*)\$" -- $override[$i])
        if test -n "$channel"
            set url "https://nixos.org/channels/$channel/nixexprs.tar.xz"
            # Replace the channel with its url
            set override[$i] (string replace -- "channel:$channel" "$url" $override[$i])
        end
    end

    # Resolve any url to a cache, else we might trigger a blocking download
    for i in (seq (count $override))
        set -l url (string match -gr "https://(.*)\$" -- $override[$i])
        if test -n "$url"
            set -l cache (_nix_resolve_url "https://$url")
            # Replace the url with the cache
            set override[$i] (string replace -- "https://$url" "$cache" $override[$i])
        end
    end

    begin
        set -lx NIX_PATH $override
        nix-instantiate --eval - 2>/dev/null | tr '[]"' ' ' | string split " " --no-empty
    end
    return $status
end


# Generate the top level expression in all the various ways the different
# commands expects it to be built. Then generate completions by calling
# _nix_attr_paths $defexpr
function _nix_complete_attr_paths
    set -l defexpr ""
    set -l file (_nix_get_file_arg)
    if test -n "$file"
        # Extract --arg and --argstr into $args
        set -l args
        set -l words (commandline -poc)
        for i in (seq (count $words))
            switch "$words[$i]"
                case "--arg"
                     set -a args "$(string unescape -- $words[$(math $i + 1)]) = $(string unescape -- $words[$(math $i + 2)]);"
                case "--argstr"
                     set -a args "$(string unescape -- $words[$(math $i + 1)]) = \"$(string unescape -- $words[$(math $i + 2)])\";"
            end
        end
        if test -n "$args"
            set args "{ $(string join " " -- $args) }"
        else
            set args ""
        end
        set defexpr "import $file $args"
        for opt in $words
            if string match -qr -- '-[^-]*E[^-]*' "$opt"; or test "$opt" = "--expr"
                set defexpr "($file) $args"
                break
            end
        end
    else
        if test "$service" = "nix-env"
            set defexpr (_nix_gen_defexpr ~/.nix-defexpr)
        #FIXME: for nix
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
        end
    end

    if test -n "$defexpr"
        _nix_attr_paths $defexpr
    end
end

function _nix_resolve_url
    set -l url "$argv[1]"
    set -l service (commandline -poc)[1]
    set -l version ($service --version)
    set -l sha
    if string match -rq '\s(1\.11\..*)$' -- $version
        # works for nix 1.11
        set sha (echo -n $url | nix-hash --flat --base32 --type sha256 /dev/stdin)
    else
        # works for nix 1.12
        set sha (string join0 -- (string replace -r '.*/' '' -- "$url") "$url" |sed '$ s/.$//'| nix-hash --flat --base32 --type sha256 /dev/stdin)
    end
    set -l cache "$(
        if set -q XDG_CACHE_HOME
            echo "$XDG_CACHE_HOME"
        else
            echo "$HOME/.cache"
        end
    )/nix/tarballs" # FIXME: this is NOT where the cache is stored now, this is outdated
    set -l link "$cache/$sha-file"
    if test -e "$link"
        echo "$cache/$(basename (readlink "$link"))-unpacked"
    end
end

function _nix_get_file_arg
    set -l words (commandline -poc)
    set -l service $words[1]
    set -l line (
        set -l cmd (commandline -poc)
        set -e cmd[1]
        for i in $cmd
            switch $i
                case "-*"
                    continue
                case "*"
                    echo $i
            end
        end)

    set -l file
    if test "$service" = "nix-env" -o "$service" = "nix"
        for i in (seq (count $words))
            switch "$words[$i]"
                case "--file" "-f"
                    set file "$words[$(math $i + 1)]"
                case "-f."
                    set file "."
            end
        end
    else if test -n "$line"
        set file "$line[1]"
    else if test -e shell.nix -a "$service" = "nix-shell"
        set file "shell.nix"
    else if test -e default.nix
        set file "default.nix"
    end

    # Remove one level of shell quoting to make sure we see the same value as
    # the nix-* program will see.
    # ($opt_args and $line contain the verbatim string:
    #  eg. given `nix-shell '<nixpkgs>' -A ` $line[1] will be `'<nixpkgs>'` while
    #  nix-shell will see `<nixpkgs>`)
    set file (string unescape -- $file)

    if test -n "$file"
        # Expand channel: syntax
        if string match -q "channel:*" -- "$file"
            set file "https://nixos.org/channels/$(string sub --start 9 -- "$file")/nixexprs.tar.xz"
        end
    end

    if test -e "$file"
        # If the path exist use the absolute path to make sure import will
        # accept it.
        # (Otherwise the path is likely a <nixpkgs> notation)
        set file (realpath "$file")
    else if string match -q "https://*" -- "$file"
        set file (_nix_resolve_url "$file")
    end
    echo -n "$file"
end

function _nix_complete_function_arg
    set -l file (_nix_get_file_arg)
    set -l func ""
    if test -n "$file"
        set func "import $file"
    end
    set -l exclude
    set -l words (commandline -poc)
    for i in (seq (math (count $words) - 1)) # Don't exclude the currently completing --arg or --argstr
        if string match -qr -- '-[^-]*E[^-]*' "$words[$i]"; or test "$words[$i]" = "--expr"
            set func $file
        end
        if test "$words[$i]" = "--arg"; or test "$words[$i]" = "--argstr"
            set -a exclude "$words[$(math $i + 1)]"
        end
    end
    if not test -n "$func"
        return
    end
    set -l get_args_expression "if builtins.typeOf ($func) == \"lambda\" then"
    set -a get_args_expression "builtins.attrNames (builtins.functionArgs ($func))"
    set -a get_args_expression "else"
    set -a get_args_expression "\"\""
    set -l names (string join \n -- $get_args_expression |_nix_eval_stdin 2>&1)
    if test $status -gt 0
        # _message "Eval failed, can't complete (an URL might not be cached):\n$names"
        return 1
    end

    for i in $names
        if not contains -- $i $exclude
            echo $i\t"Argument name"
        end
    end
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
    complete $argv -l help -d "Print help message and exit"
    complete $argv -l version -d "Print version number and exit"
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
    complete $argv -l option -xa "(_nix_options) (_nix_options_value)"
    complete $argv -l option -d "set Nix configuration option"
end

function __nix_common_nixos_build_vms
    complete $argv -l option -xa "(_nix_options) (_nix_options_value)"
    complete $argv -l option -d "set Nix configuration option"
end

function __nix_common_store_opts
    complete $argv -l add-root -xa "(__fish_complete_directories)"
    complete $argv -l add-root -d "register result as a root of the garbage collector"
    complete $argv -l indirect -d "store gc root outside GC roots directory"
end

# Used in: nix-build, nix-env, nix-instantiate, nix-shell and nix-store
function __nix_extra_build_opts
    complete $argv -l max-silent-time -d "max seconds without getting stdout/err from builder"
    complete $argv -l timeout -d "max seconds builders should run"
    complete $argv -l readonly-mode -d "do not open Nix database"
    complete $argv -l log-format -xa "pretty\tDefault"
    complete $argv -l log-format -xa "escapes\t'Indicate nesting with escape codes'"
    complete $argv -l log-format -xa "flat\t'Remove all nesting'"
    complete $argv -l log-format -d "configure how output is formatted"
end

# Used in: nix-build, nix-env, nix-instantiate, nix-shell
function __nix_common_opts
    __nix_common_nixos_rebuild $argv
    # __nix_args_opts $argv
    __nix_extra_build_opts $argv

    _nix_complete_includes $argv -l include
    complete $argv -l include -d "add a path to the list of locations used to look up <...> file names"

    complete $argv -l arg -xa "(_nix_complete_function_arg)"
    complete $argv -l arg -d "argument to pass to the Nix function"
    complete $argv -l argstr -xa "(_nix_complete_function_arg)"
    complete $argv -l argstr -d "pass a string"
end

# Options for nix-store --realise, used by nix-build
function __nix_store_realise_opts
    __nix_dry_run $argv
    complete $argv -l check -d "rebuild and see if output is deterministic"
end

