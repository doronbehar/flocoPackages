{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/maxmin?_rev=21-5687501b9a9a6564ad507fcef2b8392b";
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
    ident = "maxmin";
    ldir  = "info/unscoped/m/maxmin";
    inherit packument fetchInfo;
  } // latest';

}
