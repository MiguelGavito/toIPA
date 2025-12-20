{
  description = "IPA Translator Fullstack Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        (pkgs.python3.withPackages (ps: [
          ps.flask 
          ps.epitran
          ps.setuptools
          ps.flask-cors
        ]))        
        pkgs.nodejs
        pkgs.yarn
      ];
    };

    devShells.x86_64-linux.backend = pkgs.mkShell {
      buildInputs = [
        (pkgs.python3.withPackages (ps: [
          ps.flask 
          ps.epitran
          ps.setuptools
          ps.flask-cors
        ]))
      ];
    };

    devShells.x86_64-linux.frontend = pkgs.mkShell {
      buildInputs = [
        pkgs.nodejs
        pkgs.yarn
      ];
    };
  };
}

