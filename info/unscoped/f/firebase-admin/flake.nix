{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/firebase-admin?_rev=167-82aeb4ec565eb66bfee78e3e4ed1de14";
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
    ident = "firebase-admin";
    ldir  = "info/unscoped/f/firebase-admin";
    inherit packument fetchInfo;
  } // latest';

}
