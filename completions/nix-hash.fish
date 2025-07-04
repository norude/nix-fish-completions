__load-common-nix-options

complete nix-hash -r

complete nix-hash -l to-base16 -d "Convert a base 32 hash to hexadecimal"
complete nix-hash -l to-base32 -d "Convert a hexadecimal hash to base 32"
complete nix-hash -l flat -d "Print hash of regular files rather than their NAR dump"
complete nix-hash -l base32 -d "Print hash in base 32 rather than hexadecimal"
complete nix-hash -l truncate -d "Truncate hashes to 160 bits"
complete nix-hash -l type -xa "md5 sha1 sha256 sha512"
complete nix-hash -l type -d "Hash algorithm to use"
