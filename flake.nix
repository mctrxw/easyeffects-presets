{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    in
    {
      effects = builtins.listToAttrs (map createJsonAttr jsonFiles);
    };
}
