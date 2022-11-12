{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2fes-aggregate-error?_rev=36-a237785fd5e385d35764431de47112bf";
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
    ident = "@types/es-aggregate-error";
    ldir  = "info/types/es-aggregate-error";
    inherit packument fetchInfo;
  } // latest';

}
