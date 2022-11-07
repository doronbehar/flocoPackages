{

  inputs.packument.url   = "https://registry.npmjs.org/split-ca?rev=7-c86532c01edc4ba778a2215ef235b25d";
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
    ident = "split-ca";
    ldir  = "info/unscoped/s/split-ca";
    inherit packument fetchInfo;
  } // latest';

}
