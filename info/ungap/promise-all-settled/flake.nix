{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@ungap/promise-all-settled?_rev=5-48420b60655192074035f2091f07cd9b";
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
    scope = "@ungap";
    ident = "@ungap/promise-all-settled";
    ldir  = "info/ungap/promise-all-settled";
    inherit packument fetchInfo;
  } // latest';

}
