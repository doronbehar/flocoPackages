{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@formatjs%2fintl-pluralrules?_rev=132-9de077bb021420656e9f9827c9b539f5";
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
    scope = "@formatjs";
    ident = "@formatjs/intl-pluralrules";
    ldir  = "info/formatjs/intl-pluralrules";
    inherit packument fetchInfo;
  } // latest';

}