__load-common-nix-options

complete nix-install-package -x

complete nix-install-package -l non-interactive -d "Do not open a terminal window and do not ask for confirmation"
complete nix-install-package -l profile -s p -d "Profile to install the package into" -xa "(_nix_profiles)"
complete nix-install-package -l set -d "Install the package as the profile so that the profile contains nothing else"
complete nix-install-package -l url -d "URL to download the package file from" #:URL:_urls
complete nix-install-package -xa "*.nixpkg"
