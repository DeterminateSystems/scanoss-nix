let
  sources = import ./nix/sources.nix;

  pkgs = import sources.nixpkgs { };
  lib = pkgs.lib;
in
lib.makeScope pkgs.newScope (self: {
  scanoss-ldb = self.callPackage ./scanoss/ldb.nix { };
  scanoss-engine = self.callPackage ./scanoss/engine.nix { };
  scanoss-minr = self.callPackage ./scanoss/minr.nix { };
  scanoss-wayuu = self.callPackage ./scanoss/wayuu.nix { };
  scanoss-api = self.callPackage ./scanoss/api.nix { };
})
