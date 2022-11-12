{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/attr-accept?_rev=17-14fb942a83a01cd0d7b247f9dfb1c02a";
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
    ident = "attr-accept";
    ldir  = "info/unscoped/a/attr-accept";
    inherit packument fetchInfo;
  } // latest';

}
