{
  description = "Haskell-MOOC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, unstable, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        haskellPackages = pkgs.haskellPackages;
        unstable-pkgs = import unstable { inherit system; };
        unstableHaskellPackages = unstable-pkgs;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.cmake
            pkgs.zlib
            pkgs.zlib.dev
            haskellPackages.ghc
            haskellPackages.stack
            haskellPackages.cabal-install
            haskellPackages.haskell-language-server
          ];
        };
      });
}

