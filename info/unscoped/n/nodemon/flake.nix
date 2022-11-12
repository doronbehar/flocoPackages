{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/nodemon?_rev=1097-9ea5c374f2dd3461f294a8bf94d43814";
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
    ident = "nodemon";
    ldir  = "info/unscoped/n/nodemon";
    inherit packument fetchInfo;
  } // latest';

}
