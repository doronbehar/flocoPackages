{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/esbuild-linux-32?_rev=260-c89a79cd14d47389699dc2eb8db27df3";
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
    ident = "esbuild-linux-32";
    ldir  = "info/unscoped/e/esbuild-linux-32";
    inherit packument fetchInfo;
  } // latest';

}