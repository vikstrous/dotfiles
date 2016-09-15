Rebuild config and switch to new config

```
nixos-rebuild switch
```

Temporarily test out a config

```
nixos-rebuild test
```

Make the current config the boot default

```
nixos-rebuild boot
```

Find out the value of an option:
```
nixos-option services.xserver.enable
```

Fetch new package versions
```
nix-channel --update nixos
```
