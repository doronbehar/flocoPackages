{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/rc-select?_rev=450-007c20fd58dc81449424d2b9ee4a3637";
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
    ident = "rc-select";
    ldir  = "info/unscoped/r/rc-select";
    inherit packument fetchInfo;
  } // latest';

}
