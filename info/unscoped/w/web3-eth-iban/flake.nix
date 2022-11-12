{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/web3-eth-iban?_rev=144-53a14079ee847c68868e4b8f959e5beb";
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
    ident = "web3-eth-iban";
    ldir  = "info/unscoped/w/web3-eth-iban";
    inherit packument fetchInfo;
  } // latest';

}
