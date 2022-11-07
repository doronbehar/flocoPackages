{

  inputs.packument.url   = "https://registry.npmjs.org/object-treeify?rev=49-c888d7b118e8080a420252c037563a0e";
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
    ident = "object-treeify";
    ldir  = "info/unscoped/o/object-treeify";
    inherit packument fetchInfo;
  } // latest';

}
