{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/js2xmlparser?_rev=58-77c72e0026e63715f612e4245280a903";
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
    ident = "js2xmlparser";
    ldir  = "info/unscoped/j/js2xmlparser";
    inherit packument fetchInfo;
  } // latest';

}
