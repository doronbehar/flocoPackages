{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/utf8?_rev=29-b9f38925b74d937bb307dcc6bd610e74";
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
    ident = "utf8";
    ldir  = "info/unscoped/u/utf8";
    inherit packument fetchInfo;
  } // latest';

}
