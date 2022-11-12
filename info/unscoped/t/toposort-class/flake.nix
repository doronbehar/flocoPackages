{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/toposort-class?_rev=31-a64dd3175732471766cc06a8677d6e27";
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
    ident = "toposort-class";
    ldir  = "info/unscoped/t/toposort-class";
    inherit packument fetchInfo;
  } // latest';

}
