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
nox wget
```

Install a package as a non-root user
```
nix-env -iA packagename
```

Temporarily enter the build environment of a package
```
nix-shell '<nixpkgs>' packagename
```

Generate a hash to use in a nix package
```
nix-hash --type sha256 --flat --base32
```

Run custom docker version: build static binaries, then add to the PATH the
**absolute path** where the docker binaries are, then run dockerd
```
./dockerd --debug -s overlay2
```

Remove old roots (don't do this)
```
nix-collect-garbage -d
```

Old configuration are at:
```
/nix/var/nix/profiles/system-*-link
```
