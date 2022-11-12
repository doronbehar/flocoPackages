{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@babel/plugin-proposal-numeric-separator?_rev=82-30edb327e12298ad035ad63ff413c374";
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
    ident = "@babel/plugin-proposal-numeric-separator";
    ldir  = "info/babel/plugin-proposal-numeric-separator";
    inherit packument fetchInfo;
  } // latest';

}
