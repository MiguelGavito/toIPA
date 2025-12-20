{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.11") {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (ps: [
      ps.flask 
      ps.epitran
      ps.setuptools
      ps.flask-cors
    ]))
    curl
    jq
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
  
  ];

  shellHook = ''
    echo "Welcome to your Nix Python dev shell!"
  '';
}
