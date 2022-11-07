{

  inputs.packument.url   = "https://registry.npmjs.org/gulp-notify?rev=319-e41d295b5f3f368cf0b6162976cf27cd";
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
    ident = "gulp-notify";
    ldir  = "info/unscoped/g/gulp-notify";
    inherit packument fetchInfo;
  } // latest';

}
