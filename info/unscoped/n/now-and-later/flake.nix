{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/now-and-later?_rev=25-31d6f453b5cdaba644ef7c780f2b1079";
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
    ident = "now-and-later";
    ldir  = "info/unscoped/n/now-and-later";
    inherit packument fetchInfo;
  } // latest';

}
