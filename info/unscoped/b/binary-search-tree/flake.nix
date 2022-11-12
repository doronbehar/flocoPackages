{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/binary-search-tree?_rev=35-3773cc5f646da701a0b2bfcba81918c6";
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
    ident = "binary-search-tree";
    ldir  = "info/unscoped/b/binary-search-tree";
    inherit packument fetchInfo;
  } // latest';

}
