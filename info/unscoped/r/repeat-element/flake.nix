{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/repeat-element?_rev=11-e1eb3344b23dbe538811c99906d2053b";
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
    ident = "repeat-element";
    ldir  = "info/unscoped/r/repeat-element";
    inherit packument fetchInfo;
  } // latest';

}