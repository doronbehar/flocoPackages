{

  inputs.packument.url   = "https://registry.npmjs.org/only?rev=26-0c047e2b89a790eb3bf7de189441a32f";
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
    ident = "only";
    ldir  = "info/unscoped/o/only";
    inherit packument fetchInfo;
  } // latest';

}
