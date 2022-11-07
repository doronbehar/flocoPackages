{

  inputs.packument.url   = "https://registry.npmjs.org/url-join?rev=39-a19a56dcf2c205c79737e0fd5d9aa258";
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
    ident = "url-join";
    ldir  = "info/unscoped/u/url-join";
    inherit packument fetchInfo;
  } // latest';

}
