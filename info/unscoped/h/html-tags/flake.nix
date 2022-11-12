{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/html-tags?_rev=32-7b5d33bbabc98ff739a5c22b6aaed591";
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
    ident = "html-tags";
    ldir  = "info/unscoped/h/html-tags";
    inherit packument fetchInfo;
  } // latest';

}
