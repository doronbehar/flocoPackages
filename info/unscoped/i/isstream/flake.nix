{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/isstream?_rev=16-74103cb9a64157336a5baa0744493fde";
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
    ident = "isstream";
    ldir  = "info/unscoped/i/isstream";
    inherit packument fetchInfo;
  } // latest';

}
