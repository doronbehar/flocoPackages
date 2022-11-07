{

  inputs.packument.url   = "https://registry.npmjs.org/@sapphire/snowflake?rev=531-80ea4838d415e32a93a64ff1d7bdc646";
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
    scope = "@sapphire";
    ident = "@sapphire/snowflake";
    ldir  = "info/sapphire/snowflake";
    inherit packument fetchInfo;
  } // latest';

}
