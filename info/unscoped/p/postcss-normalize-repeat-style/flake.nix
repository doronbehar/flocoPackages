{

  inputs.packument.url   = "https://registry.npmjs.org/postcss-normalize-repeat-style?rev=39-b0bb85ee3c8a46bd99db667d657a4c87";
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
    ident = "postcss-normalize-repeat-style";
    ldir  = "info/unscoped/p/postcss-normalize-repeat-style";
    inherit packument fetchInfo;
  } // latest';

}
