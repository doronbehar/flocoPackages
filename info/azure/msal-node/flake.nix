{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@azure%2fmsal-node?_rev=50-87dc35b0866cb34c626e338d1d1bdd8f";
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
    scope = "@azure";
    ident = "@azure/msal-node";
    ldir  = "info/azure/msal-node";
    inherit packument fetchInfo;
  } // latest';

}
