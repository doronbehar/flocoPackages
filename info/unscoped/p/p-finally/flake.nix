{

  inputs.packument.url   = "https://registry.npmjs.org/p-finally?rev=10-01f3c77475901d859bda39cc656f0c63";
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
    ident = "p-finally";
    ldir  = "info/unscoped/p/p-finally";
    inherit packument fetchInfo;
  } // latest';

}
