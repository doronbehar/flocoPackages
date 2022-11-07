{

  inputs.packument.url   = "https://registry.npmjs.org/immer?rev=173-2328ece4a7b30d073afe07c250910dca";
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
    ident = "immer";
    ldir  = "info/unscoped/i/immer";
    inherit packument fetchInfo;
  } // latest';

}
