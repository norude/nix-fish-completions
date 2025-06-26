__load-common-nix-options
complete nix-push -r

complete nix-push -l dest -xa "(__fish_complete_directories (commandline -cpt) 'Destination directory')"
complete nix-push -l dest -d "Set the destination directory"
complete nix-push -l bzip2 -d "Compress NARs using bzip2 instead of xz -9"
complete nix-push -l none -d "Do not compress NARs"
complete nix-push -l force -d "Overwrite .narinfo files if they already exist"
complete nix-push -l link -d "Hard link files into the destination directory rather than copying"
complete nix-push -l manifest -d "Force the generation of a manifest suitable for use by nix-pull"
complete nix-push -l manifest-path -d "Like --manifest, but specify the manifest filename" -Fr
complete nix-push -l url-prefix -d "Specify the prefix URL used in the Manifest" #:Prefix URL:_urls
