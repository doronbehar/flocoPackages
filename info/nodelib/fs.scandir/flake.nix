{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@nodelib/fs.scandir?_rev=18-508fc5897db8829590795533c1de2076";
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
    scope = "@nodelib";
    ident = "@nodelib/fs.scandir";
    ldir  = "info/nodelib/fs.scandir";
    inherit packument fetchInfo;
  } // latest';

}
