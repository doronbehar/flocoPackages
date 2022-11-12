{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/decode-named-character-reference?_rev=3-2c891977b827a37419a9d31685cd4411";
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
    ident = "decode-named-character-reference";
    ldir  = "info/unscoped/d/decode-named-character-reference";
    inherit packument fetchInfo;
  } // latest';

}
