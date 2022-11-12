{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/xml-js?_rev=75-055c2bf32a6f4d88702f8d987e22088d";
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
    ident = "xml-js";
    ldir  = "info/unscoped/x/xml-js";
    inherit packument fetchInfo;
  } // latest';

}
