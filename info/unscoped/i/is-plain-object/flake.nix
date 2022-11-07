{

  inputs.packument.url   = "https://registry.npmjs.org/is-plain-object?rev=25-c7699822cb3de4b3b1f919ecb3cfd779";
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
    ident = "is-plain-object";
    ldir  = "info/unscoped/i/is-plain-object";
    inherit packument fetchInfo;
  } // latest';

}
