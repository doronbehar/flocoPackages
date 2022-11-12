{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/pez?_rev=99-4de451247b9322ae3cad3e061f8c7746";
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
    ident = "pez";
    ldir  = "info/unscoped/p/pez";
    inherit packument fetchInfo;
  } // latest';

}
