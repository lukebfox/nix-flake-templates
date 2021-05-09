{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates = {
      python-poetry2nix = {
        description = "A Python project built with poetry2nix";
        path = ./python/poetry2nix;
      };
      rust-crate2nix = {
        description = "Cargo crate built with crate2nix";
        path = ./rust/crate2nix;
      };
      rust-cargo2nix = {
        description = "Cargo crate built with cargo2nix";
        path = ./rust/cargo2nix;
      };
      rust-environment = {
        description = "Rust nightly development environment";
        path = ./rust/environment;
      };
      haskell-cabal2nix = {
        description = "A Haskell executable built with cabal2nix";
        path = ./haskell/cabal2nix;
      };
      elixir-environment = {
        description = "Elixir development environment";
        path = ./elixir/environment;
      };
      infrastructure = {
        description = "An infrastructure repository";
        path = ./infrastructure;
      };
    };

  };
}
