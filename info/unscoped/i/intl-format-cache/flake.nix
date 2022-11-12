{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/intl-format-cache?_rev=117-f9bc1e01da1de0129a8989fef5bed81d";
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
    ident = "intl-format-cache";
    ldir  = "info/unscoped/i/intl-format-cache";
    inherit packument fetchInfo;
  } // latest';

}