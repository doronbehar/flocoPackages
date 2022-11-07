{

  inputs.packument.url   = "https://registry.npmjs.org/y-protocols?rev=18-708991753d5a66eac60bba019618a68e";
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
    ident = "y-protocols";
    ldir  = "info/unscoped/y/y-protocols";
    inherit packument fetchInfo;
  } // latest';

}
