{

  inputs.packument.url   = "https://registry.npmjs.org/@babel/plugin-transform-typescript?rev=123-a5a5714729232e0b683c9c756d2b46f9";
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
    ident = "@babel/plugin-transform-typescript";
    ldir  = "info/babel/plugin-transform-typescript";
    inherit packument fetchInfo;
  } // latest';

}
