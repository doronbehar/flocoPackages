{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/universalify?_rev=13-7de8366fb3fa988eda8a28f0003add0b";
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
    ident = "universalify";
    ldir  = "info/unscoped/u/universalify";
    inherit packument fetchInfo;
  } // latest';

}
