{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@vue/compiler-core?_rev=134-64e2d53c42153f6ec813333e5cf01582";
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
    scope = "@vue";
    ident = "@vue/compiler-core";
    ldir  = "info/vue/compiler-core";
    inherit packument fetchInfo;
  } // latest';

}
