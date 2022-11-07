{

  inputs.packument.url   = "https://registry.npmjs.org/is-number?rev=42-10a9e05cf19bcd2240f13f7a84cb4b6a";
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
    ident = "is-number";
    ldir  = "info/unscoped/i/is-number";
    inherit packument fetchInfo;
  } // latest';

}
