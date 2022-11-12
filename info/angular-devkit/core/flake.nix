{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@angular-devkit/core?_rev=576-53addece10a8c9d48d3b032f09ac1e3b";
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
    scope = "@angular-devkit";
    ident = "@angular-devkit/core";
    ldir  = "info/angular-devkit/core";
    inherit packument fetchInfo;
  } // latest';

}
