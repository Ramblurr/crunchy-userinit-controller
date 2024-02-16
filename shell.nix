{
  system ? "x86_64-linux",
  pkgs ? import <nixpkgs> {inherit system;},
}: let
  kopf = pkgs.python3Packages.callPackage ./pkgs/kopf {};
  kubernetes_asyncio = pkgs.python3Packages.callPackage ./pkgs/kubernetes_asyncio {};
  packages = with pkgs; [
    python311
    python311Packages.asyncpg
    python311Packages.isort
    python311Packages.black
    poetry
    watchexec
    zsh
    kopf
    kubernetes_asyncio
  ];

  #LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
  #  #pkgs.stdenv.cc.cc
  #  # Add any missing library needed
  #  # You can use the nix-index package to locate them, e.g. nix-locate -w --top-level --at-root /lib/libudev.so.1
  #];

  # Put the venv on the repo, so direnv can access it
  POETRY_VIRTUALENVS_IN_PROJECT = "true";
  POETRY_VIRTUALENVS_PATH = "{project-dir}/.venv";

  # Use python from path, so you can use a different version to the one bundled with poetry
  POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON = "true";
in
  pkgs.mkShell {
    buildInputs = packages;
    #export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}"
    shellHook = ''
      export SHELL=${pkgs.zsh}
      export POETRY_VIRTUALENVS_IN_PROJECT="${POETRY_VIRTUALENVS_IN_PROJECT}"
      export POETRY_VIRTUALENVS_PATH="${POETRY_VIRTUALENVS_PATH}"
      export POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON="${POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON}"
    '';
  }
