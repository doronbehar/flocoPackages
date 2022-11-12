{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/grunt-cli?_rev=457-00690d582c72413a7de023c652830b15";
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
    ident = "grunt-cli";
    ldir  = "info/unscoped/g/grunt-cli";
    inherit packument fetchInfo;
  } // latest';

}
