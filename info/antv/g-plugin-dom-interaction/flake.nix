{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@antv/g-plugin-dom-interaction?_rev=153-dd041d05c448c677ca346939a7186423";
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
    scope = "@antv";
    ident = "@antv/g-plugin-dom-interaction";
    ldir  = "info/antv/g-plugin-dom-interaction";
    inherit packument fetchInfo;
  } // latest';

}
