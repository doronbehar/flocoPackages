{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/web3-bzz?_rev=136-3108d0d57dd840fe6191d127d818b81a";
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
    ident = "web3-bzz";
    ldir  = "info/unscoped/w/web3-bzz";
    inherit packument fetchInfo;
  } // latest';

}
