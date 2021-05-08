{
  description = "Nix Flake Template | Elixir";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.utils.url   = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      inherit (nixpkgs.lib) optional;
      pkgs = import nixpkgs { inherit system; };

      # There are multiple ways to to specify which elixir interpreter you want.

      # Dead simple
      elixir = pkgs.beam.packages.erlang.elixir;

      ## Select an intepreter based on a specific and/or overridden ErlangVM.
      #erlangR21_noHipe = erlangR21.override { enableHipe = false; };
      #elixir = (beam.packagesWith erlangR21_noHipe).elixir_1_7;

      ## Get the interpreter source from git master, not nixpkgs.
      #elixir = (beam.packagesWith erlangR21_noHipe).elixir.override {
      #  version = "1.8.0-dev";
      #  rev = "eb069dd43ba98958f4161b070d111f952b1c656c";
      #  sha256 = "0kwqdy75x0xkld1gpzz355h9yw57c6jpq1b7lz7pkn5kxywxn9qb";
      #};
    in {
      devShell = pkgs.mkShell {
        buildInputs = [
          elixir
        ] ++ optional pkgs.stdenv.isLinux pkgs.libnotify # For ExUnit Notifier on Linux.
          ++ optional pkgs.stdenv.isLinux pkgs.inotify-tools; # For file_system on Linux.
      };
    });
}
