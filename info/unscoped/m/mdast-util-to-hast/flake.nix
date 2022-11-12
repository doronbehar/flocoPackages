{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/mdast-util-to-hast?_rev=57-a4cb02722017edb70add135d01bb3299";
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
    ident = "mdast-util-to-hast";
    ldir  = "info/unscoped/m/mdast-util-to-hast";
    inherit packument fetchInfo;
  } // latest';

}
