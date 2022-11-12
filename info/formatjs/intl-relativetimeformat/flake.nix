{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@formatjs%2fintl-relativetimeformat?_rev=160-af16fe38446f7c9652557a0c9d08f851";
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
    ident = "@formatjs/intl-relativetimeformat";
    ldir  = "info/formatjs/intl-relativetimeformat";
    inherit packument fetchInfo;
  } // latest';

}
