{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/tar-fs?_rev=102-de13b9de1a5306dcd328884954f74129";
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
    ident = "tar-fs";
    ldir  = "info/unscoped/t/tar-fs";
    inherit packument fetchInfo;
  } // latest';

}
