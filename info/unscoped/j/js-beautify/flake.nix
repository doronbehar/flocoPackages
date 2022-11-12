{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/js-beautify?_rev=270-e9931b6a5edfa540ce277a41cb544526";
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
    ident = "js-beautify";
    ldir  = "info/unscoped/j/js-beautify";
    inherit packument fetchInfo;
  } // latest';

}
