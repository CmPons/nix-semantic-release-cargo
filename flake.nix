{
  description = "Semantic Release Cargo";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    semantic-release-cargo-repo.url =
      "github:semantic-release-cargo/semantic-release-cargo";
  };
  outputs = { nixpkgs, flake-utils, semantic-release-cargo-repo, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        rustPlatform = pkgs.rustPlatform;
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        semantic-release-cargo = rustPlatform.buildRustPackage {
          pname = "semantic-release-cargo";
          version = "v2.4.24";

          src = semantic-release-cargo-repo;
          cargoLock = {
            lockFile = "${semantic-release-cargo-repo}/Cargo.lock";
          };

          meta = with pkgs.lib; {
            description = "Integrate a Rust project with semantic-release";
            homepage =
              "https://github.com/semantic-release-cargo/semantic-release-cargo";
            license = licenses.unlicense;
          };
        };

      in {
        packages.semantic-release-cargo = semantic-release-cargo;
        packages.default = semantic-release-cargo;
      });
}
