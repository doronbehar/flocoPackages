{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/parse-cache-control?_rev=6-0c132e8772202f8eb47f42151f79f673";
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
    ident = "parse-cache-control";
    ldir  = "info/unscoped/p/parse-cache-control";
    inherit packument fetchInfo;
  } // latest';

}
