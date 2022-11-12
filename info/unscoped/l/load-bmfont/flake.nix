{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/load-bmfont?_rev=23-ce3f315464d27896982821bd3183691b";
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
    ident = "load-bmfont";
    ldir  = "info/unscoped/l/load-bmfont";
    inherit packument fetchInfo;
  } // latest';

}
