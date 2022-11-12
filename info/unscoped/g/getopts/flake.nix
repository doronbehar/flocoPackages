{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/getopts?_rev=33-53f0876c09532d1c1f535b172c08d498";
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
    ident = "getopts";
    ldir  = "info/unscoped/g/getopts";
    inherit packument fetchInfo;
  } // latest';

}
