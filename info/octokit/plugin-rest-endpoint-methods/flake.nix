{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@octokit/plugin-rest-endpoint-methods?_rev=163-fc007e8b79ce764be9382598a567ff3c";
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
    scope = "@octokit";
    ident = "@octokit/plugin-rest-endpoint-methods";
    ldir  = "info/octokit/plugin-rest-endpoint-methods";
    inherit packument fetchInfo;
  } // latest';

}
