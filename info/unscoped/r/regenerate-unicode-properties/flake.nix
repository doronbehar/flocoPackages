{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/regenerate-unicode-properties?_rev=34-c9d40faa78800abe56aeb043bc1bc485";
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
    ident = "regenerate-unicode-properties";
    ldir  = "info/unscoped/r/regenerate-unicode-properties";
    inherit packument fetchInfo;
  } // latest';

}
