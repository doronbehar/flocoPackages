{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/log-driver?_rev=22-294f1658d5c91cc021894379d7fd4fd0";
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
    ident = "log-driver";
    ldir  = "info/unscoped/l/log-driver";
    inherit packument fetchInfo;
  } // latest';

}
