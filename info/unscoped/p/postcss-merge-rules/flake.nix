{

  inputs.packument.url   = "https://registry.npmjs.org/postcss-merge-rules?rev=79-f5fd86f8d9cf08ef709020c126d9649a";
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
    ident = "postcss-merge-rules";
    ldir  = "info/unscoped/p/postcss-merge-rules";
    inherit packument fetchInfo;
  } // latest';

}
