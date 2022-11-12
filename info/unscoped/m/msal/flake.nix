{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/msal?_rev=105-4804e3f9e98b9644a5ca629b63a15ebe";
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
    ident = "msal";
    ldir  = "info/unscoped/m/msal";
    inherit packument fetchInfo;
  } // latest';

}