{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/boom?_rev=325-ced604225604f25aeb6638892dc10a61";
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
    ident = "boom";
    ldir  = "info/unscoped/b/boom";
    inherit packument fetchInfo;
  } // latest';

}
