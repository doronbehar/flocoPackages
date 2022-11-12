{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@netflix%2fnerror?_rev=10-1f3c67c6f09facb4da591264021ec2ff";
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
    scope = "@netflix";
    ident = "@netflix/nerror";
    ldir  = "info/netflix/nerror";
    inherit packument fetchInfo;
  } // latest';

}
