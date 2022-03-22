{
  description = ''Frida wrapper'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-frida-master.flake = false;
  inputs.src-frida-master.owner = "ba0f3";
  inputs.src-frida-master.ref   = "master";
  inputs.src-frida-master.repo  = "frida.nim";
  inputs.src-frida-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-frida-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-frida-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}