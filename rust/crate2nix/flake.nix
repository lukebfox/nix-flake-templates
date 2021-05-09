{
  description = "Cargo crate built with crate2nix";

  inputs = {
    nixpkgs      = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
    rust-overlay = { url = "github:oxalica/rust-overlay"; };
    crate2nix    = { url = "github:kolloch/crate2nix"; flake = false; };
    flake-utils  = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, rust-overlay, crate2nix, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays      = [ (import rust-overlay) ];
      pkgs          = import nixpkgs { inherit system overlays; };

      crate2nix-lib = import "${crate2nix}/tools.nix" { inherit pkgs; };

      crateName = "crate-name";
    in {

      packages.${crateName} = (pkgs.callPackage
        (crate2nix-lib.generatedCargoNix {
          name = crateName;
          src = ./.;
        }) {
          defaultCrateOverrides = pkgs.defaultCrateOverrides // {
            # Crate dependency overrides go here
          };
        }).rootCrate.build;

      defaultPackage = self.packages.${system}.${crateName};

      devShell = pkgs.mkShell {
        inputsFrom = builtins.attrValues self.packages.${system};
        buildInputs = [
          pkgs.openssl
          pkgs.rust-bin.stable.latest.default
          pkgs.rust-analyzer
          pkgs.clippy
        ];
      };

    });
}
