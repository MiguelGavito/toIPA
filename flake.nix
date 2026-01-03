{
  description = "IPA Translator Fullstack Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
        f nixpkgs.legacyPackages.${system}
      );
    in {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
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
        backend = pkgs.mkShell {
          buildInputs = [
            (pkgs.python3.withPackages (ps: [
              ps.flask
              ps.epitran
              ps.setuptools
              ps.flask-cors
            ]))
          ];
        };
        frontend = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
            pkgs.yarn
          ];
        };
      });
    };
}

