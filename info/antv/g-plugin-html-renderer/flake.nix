{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@antv/g-plugin-html-renderer?_rev=129-5d36da0e567f5468928f3e425dd1ef10";
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
    ident = "@antv/g-plugin-html-renderer";
    ldir  = "info/antv/g-plugin-html-renderer";
    inherit packument fetchInfo;
  } // latest';

}
