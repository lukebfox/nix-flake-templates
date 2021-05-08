{
  description = "Nix Flake Template | Python";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.utils.url   = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

      python = pkgs.python39;
      projectDir = ./.;
      overrides = pkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix pkgs);
    in {

      devShell.${system} = pkgs.mkShell {
        buildInputs = [
          pkgs.python39Packages.poetry
          (pkgs.poetry2nix.mkPoetryEnv {
            inherit python projectDir overrides;
          })
        ];
      };

      packages.${system} = {
        package-name = pkgs.poetry2nix.mkPoetryApplication {
          inherit python projectDir overrides;
          # non-python runtime deps...
          propogatedBuildInputs = [];
        };
      };

    });

}
