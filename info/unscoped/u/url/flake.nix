{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/url?_rev=103-abbceda38b54e3ba7b4c45881c11d08c";
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
    ident = "url";
    ldir  = "info/unscoped/u/url";
    inherit packument fetchInfo;
  } // latest';

}
