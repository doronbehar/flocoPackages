{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/d3-brush?_rev=44-c59683847c25db40c37a47ea2248bdfa";
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
    ident = "d3-brush";
    ldir  = "info/unscoped/d/d3-brush";
    inherit packument fetchInfo;
  } // latest';

}
