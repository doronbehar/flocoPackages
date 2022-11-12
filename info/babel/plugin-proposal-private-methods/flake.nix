{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@babel/plugin-proposal-private-methods?_rev=33-f0e200e1a3a97036e6609323d5e6e1bc";
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
    scope = "@babel";
    ident = "@babel/plugin-proposal-private-methods";
    ldir  = "info/babel/plugin-proposal-private-methods";
    inherit packument fetchInfo;
  } // latest';

}
