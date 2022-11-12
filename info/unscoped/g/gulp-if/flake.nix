{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/gulp-if?_rev=235-07795cf7e0de890cd68a639e24af86ea";
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
    ident = "gulp-if";
    ldir  = "info/unscoped/g/gulp-if";
    inherit packument fetchInfo;
  } // latest';

}
