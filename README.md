# Install
Install nextflow by putting something like this in your config:

> flake.nix
```nix
{
    inputs = { nextflow.url = "github:IllustratedMan-code/nextflowFlake" };

}
```
> ...
```nix
{
    environment.systemPackages = [ inputs.nextflow.packages.x86_64-linux.default ];

}
```

If there are any problems, don't hesitate to file an issue!
