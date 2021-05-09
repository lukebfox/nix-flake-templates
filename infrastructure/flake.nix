{
  description = "An infrastructure repository";

  inputs = {
    nixpkgs.url          = "nixpkgs/nixos-unstable";
    nixops-plugged.url   = "github:lukebfox/nixops-plugged";
    flake-utils.url      = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixops-plugged, flake-utils, ... }: {

    nixopsConfigurations.default =  let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      # NixOps network expressions go here
    };

  } // flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
  in {

    devShell = pkgs.mkShell {
      nativeBuildInputs = [
        nixops-plugged
      ];
    };

  });
}
