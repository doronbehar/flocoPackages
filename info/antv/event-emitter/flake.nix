{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@antv/event-emitter?_rev=61-af1db5ab8b7e75c5fad7c72a634355a6";
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
    scope = "@antv";
    ident = "@antv/event-emitter";
    ldir  = "info/antv/event-emitter";
    inherit packument fetchInfo;
  } // latest';

}
