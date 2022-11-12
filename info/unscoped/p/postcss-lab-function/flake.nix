{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/postcss-lab-function?_rev=21-52810069f63f6d1a160a49641d36daa5";
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
    ident = "postcss-lab-function";
    ldir  = "info/unscoped/p/postcss-lab-function";
    inherit packument fetchInfo;
  } // latest';

}
