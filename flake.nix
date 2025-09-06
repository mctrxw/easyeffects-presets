{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs)
        lib
        ;

      jsonFiles = builtins.filter (name: lib.hasSuffix ".json" name) (
        builtins.attrNames (builtins.readDir ./.)
      );

      createJsonAttr = fileName: {
        name = lib.removeSuffix ".json" fileName;
        value = builtins.fromJSON (builtins.readFile (./. + "/${fileName}"));
      };

      jsonAttrs = builtins.listToAttrs (map createJsonAttr jsonFiles);

    in
    jsonAttrs;
}
