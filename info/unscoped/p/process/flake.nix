{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/process?_rev=56-048a847a1ebf82105dec7bffd517bcd8";
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
    ident = "process";
    ldir  = "info/unscoped/p/process";
    inherit packument fetchInfo;
  } // latest';

}
