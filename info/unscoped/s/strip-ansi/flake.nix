{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/strip-ansi?_rev=59-0a4a4d5e20630c0ef94861a6fe001ffd";
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
    ident = "strip-ansi";
    ldir  = "info/unscoped/s/strip-ansi";
    inherit packument fetchInfo;
  } // latest';

}
