Rebuild config and switch to new config

```
nixos-rebuild switch -I nixpkgs=/home/v/nixpkgs
```

Temporarily test out a config

```
nixos-rebuild test -I nixpkgs=/home/v/nixpkgs
```

Make the current config the boot default (doesn't activate it right now)

```
nixos-rebuild boot -I nixpkgs=/home/v/nixpkgs
```

Find out the value of an option:
```
nixos-option services.xserver.enable
```

Fetch new package versions
```
nix-channel --update nixos
```

Search for packages
```
nix-env -qaP | grep wget
```
