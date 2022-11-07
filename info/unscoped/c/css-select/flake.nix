{

  inputs.packument.url   = "https://registry.npmjs.org/css-select?rev=39-18100928c9466d27095823f00b74c769";
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
    ident = "css-select";
    ldir  = "info/unscoped/c/css-select";
    inherit packument fetchInfo;
  } // latest';

}
