# nix environment setup
# translated from '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	set -gx NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"
	set -gx NIX_SSL_CERT_FILE /etc/pki/tls/certs/ca-bundle.crt # Fedora specific
	set -gx NIX_PATH nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels
	fish_add_path $HOME/.nix-profile/bin
	fish_add_path /nix/var/nix/profiles/default/bin
end
