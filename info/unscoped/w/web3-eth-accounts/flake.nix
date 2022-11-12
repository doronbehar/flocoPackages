{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/web3-eth-accounts?_rev=138-c81fe65a28029728226c6c4acfd3a310";
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
    ident = "web3-eth-accounts";
    ldir  = "info/unscoped/w/web3-eth-accounts";
    inherit packument fetchInfo;
  } // latest';

}
