{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/web3-eth-contract?_rev=143-be9bcee25f31dfca2ec62a8603787687";
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
    ident = "web3-eth-contract";
    ldir  = "info/unscoped/w/web3-eth-contract";
    inherit packument fetchInfo;
  } // latest';

}
