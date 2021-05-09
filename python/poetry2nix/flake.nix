{
  description = "Python application managed with poetry2nix";

  inputs = {
    nixpkgs     = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };

      python = pkgs.python39;
      projectDir = ./.;
      overrides = pkgs.poetry2nix.overrides.withDefaults (final: prev: {
        # Python dependency overrides go here
      });

      packageName = "package-name";
    in {

      packages.${packageName} = pkgs.poetry2nix.mkPoetryApplication {
        inherit python projectDir overrides;
        # Non-Python runtime dependencies go here
        propogatedBuildInputs = [];
      };

      defaultPackage = self.packages.${system}.${packageName};

      devShell = pkgs.mkShell {
        buildInputs = [
          (pkgs.poetry2nix.mkPoetryEnv {
            inherit python projectDir overrides;
          })
          pkgs.python39Packages.poetry
        ];
      };

    });
}
