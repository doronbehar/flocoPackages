{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/is-png?_rev=15-9fb7988d837dfbd01f49bc1935d86278";
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
    ident = "is-png";
    ldir  = "info/unscoped/i/is-png";
    inherit packument fetchInfo;
  } // latest';

}
