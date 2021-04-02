{
  description = "Testing flake for elixir projects.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      inherit (nixpkgs.lib) optional;

      pkgs = import nixpkgs { inherit system; };

      # Ways to specify an elixir:

      # default
      elixir = pkgs.beam.packages.erlang.elixir;

      /*
      # Based on a specific and overridden ErlangVM.
      #erlangR21_noHipe = erlangR21.override { enableHipe = false; };
      #elixir = (beam.packagesWith erlangR21_noHipe).elixir_1_7;

      # Get elixir source from git master, not nixpkgs.
      elixir = (beam.packagesWith erlangR21_noHipe).elixir.override {
        version = "1.8.0-dev";
        rev = "eb069dd43ba98958f4161b070d111f952b1c656c";
        sha256 = "0kwqdy75x0xkld1gpzz355h9yw57c6jpq1b7lz7pkn5kxywxn9qb";
      };
      */

    in
      {

          devShell = pkgs.mkShell {
          buildInputs = [
            elixir
          ] ++ optional pkgs.stdenv.isLinux pkgs.libnotify # For ExUnit Notifier on Linux.
            ++ optional pkgs.stdenv.isLinux pkgs.inotify-tools; # For file_system on Linux.
        };
      }
  );

}
