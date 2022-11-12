{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/win-release?_rev=13-040a35c32736ba29fb95aebcc85cf02e";
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
    ident = "win-release";
    ldir  = "info/unscoped/w/win-release";
    inherit packument fetchInfo;
  } // latest';

}