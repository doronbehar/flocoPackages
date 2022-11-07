{

  inputs.packument.url   = "https://registry.npmjs.org/@alifd/overlay?rev=38-e5d565d17c3415ff1d6bf101800b0388";
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
    scope = "@alifd";
    ident = "@alifd/overlay";
    ldir  = "info/alifd/overlay";
    inherit packument fetchInfo;
  } // latest';

}
