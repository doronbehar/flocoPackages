{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2fsnowflake-sdk?_rev=233-61d0f0dff6081a657126e19385a0ae1c";
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
    ident = "@types/snowflake-sdk";
    ldir  = "info/types/snowflake-sdk";
    inherit packument fetchInfo;
  } // latest';

}