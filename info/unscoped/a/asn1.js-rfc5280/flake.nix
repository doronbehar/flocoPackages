{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/asn1.js-rfc5280?_rev=18-1ed81f4b316280544d9b4b90ea8f0012";
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
    ident = "asn1.js-rfc5280";
    ldir  = "info/unscoped/a/asn1.js-rfc5280";
    inherit packument fetchInfo;
  } // latest';

}