{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/lowercase-keys?_rev=13-7606f21fbb4d40fbeeb90b3b4d626b9a";
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
    ident = "lowercase-keys";
    ldir  = "info/unscoped/l/lowercase-keys";
    inherit packument fetchInfo;
  } // latest';

}
