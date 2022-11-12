{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@lezer%2fcommon?_rev=17-962f42b8344029c7363fcdaae86ff7be";
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
    scope = "@lezer";
    ident = "@lezer/common";
    ldir  = "info/lezer/common";
    inherit packument fetchInfo;
  } // latest';

}
