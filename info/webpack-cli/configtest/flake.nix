{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@webpack-cli/configtest?_rev=9-9ad93f7ad71ab332e351b7cee8f585af";
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
    scope = "@webpack-cli";
    ident = "@webpack-cli/configtest";
    ldir  = "info/webpack-cli/configtest";
    inherit packument fetchInfo;
  } // latest';

}
