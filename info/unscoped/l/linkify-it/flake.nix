{

  inputs.packument.url   = "https://registry.npmjs.org/linkify-it?rev=44-e597541e0584d65a1790a590cf0aef14";
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
    ident = "linkify-it";
    ldir  = "info/unscoped/l/linkify-it";
    inherit packument fetchInfo;
  } // latest';

}
