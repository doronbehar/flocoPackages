{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@npmcli%2fquery?_rev=8-53d9df37991f2311609977dfc34a6ab7";
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
    scope = "@npmcli";
    ident = "@npmcli/query";
    ldir  = "info/npmcli/query";
    inherit packument fetchInfo;
  } // latest';

}
