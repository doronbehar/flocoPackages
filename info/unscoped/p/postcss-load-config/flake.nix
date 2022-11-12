{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/postcss-load-config?_rev=30-df124af0a99d953ed019d8ea14fc148f";
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
    ident = "postcss-load-config";
    ldir  = "info/unscoped/p/postcss-load-config";
    inherit packument fetchInfo;
  } // latest';

}
