__load-common-nix-options

complete nix-prefetch-url -x

function _nix-prefetch-url_arguments
    echo 'https://'\t'HTTPS URL'
    echo 'http://'\t'HTTP URL'
    echo 'mirror://'\t'Mirror defined in nixpkgs'
    set -l cur (commandline -cpt | string replace -r '^file://' '' )
    set -l files (complete -C "'' $cur")
    string join \n -- 'file://'$files\t'Local file'
end

__nix_search_path_args nix-prefetch-url
complete nix-prefetch-url -l unpack -d "Unpack tarball/zip first"
complete nix-prefetch-url -l print-path -d "Print the resulting store path"
complete nix-prefetch-url -l type -xa "md5 sha1 sha256 sha512"
complete nix-prefetch-url -l type -d "Use the specified hash algorithm"
complete nix-prefetch-url -l name -d "Override the resulting nix store filename"
complete nix-prefetch-url -l attr -s A -xa "(_nix_complete_attr_paths)"
complete nix-prefetch-url -l attr -s A -d "Fetch the src of derivation (eg. mpv.src)"

complete nix-prefetch-url -kxa "(_nix-prefetch-url_arguments)"
