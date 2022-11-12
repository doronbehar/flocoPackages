{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@apideck%2fbetter-ajv-errors?_rev=17-efb33cf92143e7f98852aab7b4587b75";
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
    scope = "@apideck";
    ident = "@apideck/better-ajv-errors";
    ldir  = "info/apideck/better-ajv-errors";
    inherit packument fetchInfo;
  } // latest';

}
