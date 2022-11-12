{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/multimatch?_rev=29-18ac3cc06f816abcffa1cd383e8ed7ea";
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
    ident = "multimatch";
    ldir  = "info/unscoped/m/multimatch";
    inherit packument fetchInfo;
  } // latest';

}
