{
  description = "Rust nightly development environment.";

  inputs = {
    nixpkgs      = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
    rust-overlay = { url = "github:oxalica/rust-overlay"; };
    flake-utils  = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [ (import rust-overlay) ];
      pkgs = import nixpkgs { inherit system overlays; };
    in {
      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.rust-bin.nightly.latest.default
          pkgs.rust-analyser
          pkgs.clippy
        ];
      };
    });
}
