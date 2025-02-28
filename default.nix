{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib, }:
let
  rustPlatform = pkgs.rustPlatform;
  crmRepo = builtins.fetchGit {
    url =
      "https://github.com/semantic-release-cargo/semantic-release-cargo.git";
    ref = "master";
  };
in rustPlatform.buildRustPackage {
  pname = "semantic-release-cargo";
  version = "v2.4.24";

  src = crmRepo;
  cargoLock = { lockFile = "${crmRepo}/Cargo.lock"; };

  meta = with lib; {
    description = "Integrate a Rust project with semantic-release";
    homepage =
      "https://github.com/semantic-release-cargo/semantic-release-cargo";
    license = licenses.unlicense;
  };
}
