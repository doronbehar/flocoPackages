{

  inputs.packument.url   = "https://registry.npmjs.org/escape-string-regexp?rev=57-3b2118e1e7ac7e864999b3cc67e9aa8f";
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
    ident = "escape-string-regexp";
    ldir  = "info/unscoped/e/escape-string-regexp";
    inherit packument fetchInfo;
  } // latest';

}
