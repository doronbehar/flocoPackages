{

  inputs.packument.url   = "https://registry.npmjs.org/keycode?rev=49-448f9c1365374da9c47a0b8172a567d7";
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
    ident = "keycode";
    ldir  = "info/unscoped/k/keycode";
    inherit packument fetchInfo;
  } // latest';

}
