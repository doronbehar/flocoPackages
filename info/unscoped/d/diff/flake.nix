{

  inputs.packument.url   = "https://registry.npmjs.org/diff?rev=159-ea83272b1f07ba7391eeca09eaaddb70";
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
    ident = "diff";
    ldir  = "info/unscoped/d/diff";
    inherit packument fetchInfo;
  } // latest';

}
