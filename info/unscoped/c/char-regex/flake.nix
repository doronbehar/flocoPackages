{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/char-regex?_rev=5-df40e228f0eec08b102aee628148bde1";
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
    ident = "char-regex";
    ldir  = "info/unscoped/c/char-regex";
    inherit packument fetchInfo;
  } // latest';

}
