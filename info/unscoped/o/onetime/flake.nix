{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/onetime?_rev=27-fa8ba5710a32ca9dab042793bf111371";
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
    ident = "onetime";
    ldir  = "info/unscoped/o/onetime";
    inherit packument fetchInfo;
  } // latest';

}
