{
  description = "Semantic Release Cargo";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        semantic-release-cargo = pkgs.callPackage ./default.nix { };
      in {
        packages.semantic-release-cargo = semantic-release-cargo;
        packages.default = semantic-release-cargo;
      });
}
