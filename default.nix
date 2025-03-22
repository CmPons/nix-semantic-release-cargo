{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib, }:
let
  rustPlatform = pkgs.rustPlatform;
  crmRepo = pkgs.fetchFromGitHub {
    owner = "semantic-release-cargo";
    repo = "semantic-release-cargo";
    rev = "master";
    sha256 = "sha256-rGIwPjA3e49s7hu/2S6jlRnKSH1JTHzR+PJBD5GjZQU=";
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
