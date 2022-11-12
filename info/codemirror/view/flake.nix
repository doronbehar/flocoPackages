{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@codemirror/view?_rev=108-9cbdbd3ac9f3e62af90439f374608382";
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
    scope = "@codemirror";
    ident = "@codemirror/view";
    ldir  = "info/codemirror/view";
    inherit packument fetchInfo;
  } // latest';

}
