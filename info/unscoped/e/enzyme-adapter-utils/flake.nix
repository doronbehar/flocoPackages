{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/enzyme-adapter-utils?_rev=43-47b1ec2c0081bd84c3f550df279739ef";
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
    ident = "enzyme-adapter-utils";
    ldir  = "info/unscoped/e/enzyme-adapter-utils";
    inherit packument fetchInfo;
  } // latest';

}
