{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types/react-redux?_rev=918-5317ab524019e376271febda868e120d";
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
    scope = "@types";
    ident = "@types/react-redux";
    ldir  = "info/types/react-redux";
    inherit packument fetchInfo;
  } // latest';

}
