{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@ethersproject/bignumber?_rev=53-c1b1f34792cad56cb7eb8443762992ce";
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
    scope = "@ethersproject";
    ident = "@ethersproject/bignumber";
    ldir  = "info/ethersproject/bignumber";
    inherit packument fetchInfo;
  } // latest';

}
