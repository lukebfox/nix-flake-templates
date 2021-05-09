# Start packaging projects with flakes *without* the fuss

This is a small collection of flake templates for use when developing software intended to be built or distributed with Nix flakes.

## Usage

Initialising a Python-based application managed with Poetry and Nix is as simple as
```shell
nix flake init -t "github:lukebfox/nix-flake-templates#python-poetry2nix"
git init && git add .
```
which will give you
```text
myproject
├─flake.nix
├─flake.lock
├─pyproject.toml
├─poetry.lock
├─.gitignore
└─.envrc
```

## Templates

``` shell
$ nix flake show "github:lukebfox/nix-flake-templates"

github:lukebfox/nix-configs/<commit-hash>
└───templates
    ├───elixir-environment: template: Elixir development environment
    ├───haskell-cabal2nix: template: A Haskell executable built with cabal2nix
    ├───infrastructure: template: An infrastructure repository
    ├───python-poetry2nix: template: A Python project built with poetry2nix
    ├───rust-cargo2nix: template: Cargo crate built with cargo2nix
    ├───rust-crate2nix: template: Cargo crate built with crate2nix
    └───rust-environment: template: Rust nightly development environment
```

## Contributing

If you want more like this feel free to open up an issue or a PR. Let's spread the flakes knowledge!


---
##### More like this
nixos/templates
serokell/templates
