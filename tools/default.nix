let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
    sha256 = "1avlwbghhyzxqv72f5rh7bwbfkzyf237w7hlw119dlf7jgc7x3f1";
  };
  pkgs = import nixpkgs {};
in
  pkgs.writeShellApplication {
    name = "bazel-wrapper";

    runtimeInputs = with pkgs;
      [
        bash
        bazelisk
        coreutils
        findutils
        gnugrep
        nix
      ]
      ++ lib.optionals stdenv.isDarwin [
        darwin.cctools
      ];

    inheritPath = false;

    text = ''
      exec bazelisk "$@"
    '';
  }
