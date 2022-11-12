{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/byline?_rev=70-50c69ee4ce09c7fac7561ac22ebdbe75";
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
    ident = "byline";
    ldir  = "info/unscoped/b/byline";
    inherit packument fetchInfo;
  } // latest';

}
