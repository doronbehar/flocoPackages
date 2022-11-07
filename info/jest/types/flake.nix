{

  inputs.packument.url   = "https://registry.npmjs.org/@jest/types?rev=95-4cec4e2f7ea68027470c68dff740d1b2";
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
    scope = "@jest";
    ident = "@jest/types";
    ldir  = "info/jest/types";
    inherit packument fetchInfo;
  } // latest';

}
