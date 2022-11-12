{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@ant-design%2ficons-svg?_rev=41-f8606aabf6bbfce4c834913a9f9586df";
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
    scope = "@ant-design";
    ident = "@ant-design/icons-svg";
    ldir  = "info/ant-design/icons-svg";
    inherit packument fetchInfo;
  } // latest';

}
