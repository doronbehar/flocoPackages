{

  inputs.packument.url   = "https://registry.npmjs.org/rss-parser?rev=84-e1470ecfa825f7c2a78d5596fd4f89b0";
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
    ident = "rss-parser";
    ldir  = "info/unscoped/r/rss-parser";
    inherit packument fetchInfo;
  } // latest';

}
