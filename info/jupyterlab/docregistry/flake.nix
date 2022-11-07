{

  inputs.packument.url   = "https://registry.npmjs.org/@jupyterlab/docregistry?rev=444-ee5b114180526703e4a05a9cf367aa9a";
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
    scope = "@jupyterlab";
    ident = "@jupyterlab/docregistry";
    ldir  = "info/jupyterlab/docregistry";
    inherit packument fetchInfo;
  } // latest';

}
