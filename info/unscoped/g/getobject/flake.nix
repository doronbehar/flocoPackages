{

  inputs.packument.url   = "https://registry.npmjs.org/getobject?rev=15-81877888c9c0ce4c251f4a809b4f236c";
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
    ident = "getobject";
    ldir  = "info/unscoped/g/getobject";
    inherit packument fetchInfo;
  } // latest';

}
