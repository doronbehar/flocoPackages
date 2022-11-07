{

  inputs.packument.url   = "https://registry.npmjs.org/latest-version?rev=31-5b9921c639b9c114a242b0c8b08504b7";
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
    ident = "latest-version";
    ldir  = "info/unscoped/l/latest-version";
    inherit packument fetchInfo;
  } // latest';

}
