{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/memfs?_rev=115-2cff85d9afab123d62678fb53a76a067";
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
    ident = "memfs";
    ldir  = "info/unscoped/m/memfs";
    inherit packument fetchInfo;
  } // latest';

}
