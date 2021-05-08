{
  description = "Nix Flake Template | Rust";

  inputs.nixpkgs.url      = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.rust-overlay.url = "github:oxalica/rust-overlay";
  inputs.utils.url        = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, rust-overlay, utils, ... }: utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.openssl
            pkgs.pkgconfig
            pkgs.rust-bin.stable.latest.default
          ];
        };
      });
}
