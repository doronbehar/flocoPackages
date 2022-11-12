{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/extglob?_rev=22-87f08b1adb8afd7deff6b71e9956ed7f";
  inputs.packument.flake = false;

  outputs = inputs: let
    importJSON = f: builtins.fromJSON ( builtins.readFile f );
    packument  = importJSON inputs.packument;
    fetchInfo  = if ! builtins.pathExists ./fetchInfo.json then {} else
                 importJSON ./fetchInfo.json;
    latest'    = if ! ( packument ? dist-tags.latest ) then {} else {
      latestVersion = packument.dist-tags.latest;
      latest        = packument.versions.${packument.dist-tags.latest};
    };
  in {
    scope = null;
    ident = "extglob";
    ldir  = "info/unscoped/e/extglob";
    inherit packument fetchInfo;
  } // latest';

}