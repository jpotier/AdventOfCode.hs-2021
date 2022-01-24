# Seeded from: https://github.com/MasseR/ics-print/blob/main/flake.nix
{
  description = "AdventOfCode 2021";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    easy-hls = {
      url = "github:jkachmar/easy-hls-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, easy-hls }:
    flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin"] ( system:
      let
        pkgs = import nixpkgs { inherit system; };
        hp = pkgs.haskellPackages.extend (self: super: {
          adventofcode = self.callCabal2nix "adventofcode"  ./. {};
        });
        hls = easy-hls.defaultPackage.${system};
      in
      rec {

        packages = { inherit (hp) adventofcode; };

        defaultPackage = packages.adventofcode;

        apps.adventofcode = flake-utils.lib.mkApp { drv = packages.adventofcode; };
        defaultApp = apps.adventofcode;

        devShell = hp.shellFor {
          packages = h: [h.adventofcode];
          withHoogle = true;
          buildInputs = with pkgs; [
            entr
            cabal-install
            hp.hlint
            stylish-haskell
            ghcid
            hls
          ];
        };
      }
    );
}
