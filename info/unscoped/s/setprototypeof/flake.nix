{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/setprototypeof?_rev=17-588553621efc16fdd88f4319ebd8f3b6";
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
    ident = "setprototypeof";
    ldir  = "info/unscoped/s/setprototypeof";
    inherit packument fetchInfo;
  } // latest';

}
