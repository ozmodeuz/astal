{
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  autoconf-archive,
  alsa-lib,
  fftw,
  iniparser,
  libpulseaudio,
  portaudio,
  sndio,
  SDL2,
  libGL,
  pipewire,
  jack2,
  ncurses,
  pkgconf,
  meson,
  ninja,
}:
{
nixpkgs.overlays = [
  (final: prev: {
    autoconf-archive = prev.autoconf-archive.override {
      patches = [
        (fetchurl {
          url = "https://raw.githubusercontent.com/NixOS/nixpkgs/f4acddd86c8d57f3ec06e93eb957f73c0bdc0e60/pkgs/by-name/au/autoconf-archive/0001-ax_check_gl.m4-properly-quote-m4_fatal.patch";
          hash = "sha256-kOMEnw3vZeEx+/OMdJ95rc5mdgIx5/1ftADk3q8stbQ=";
        })
        (fetchurl {
          url = "https://raw.githubusercontent.com/NixOS/nixpkgs/f4acddd86c8d57f3ec06e93eb957f73c0bdc0e60/pkgs/by-name/au/autoconf-archive/0002-ax_check_glx.m4-properly-quote-m4_fatal.patch";
          hash = "sha256-UvAGFwyBgZW2n3U9IaXHnSygCq578BftBUA/PWkZQpw=";
        })
        (fetchurl {
          url = "https://github.com/NixOS/nixpkgs/blob/f4acddd86c8d57f3ec06e93eb957f73c0bdc0e60/pkgs/by-name/au/autoconf-archive/0003-ax_switch_flags.m4-properly-quote-m4_fatal.patch";
          hash = "sha256-Jl7d3vqb90WGMIQu162OPRA6SqDQgR6hPwgAmBJGXp4=";
        })
      ];
    };
  })
];

stdenv.mkDerivation rec {
  pname = "cava";
  version = "0.10.3";

  src = fetchFromGitHub {
    owner = "LukashonakV";
    repo = "cava";
    rev = "0.10.3";
    hash = "sha256-ZDFbI69ECsUTjbhlw2kHRufZbQMu+FQSMmncCJ5pagg=";
  };

  buildInputs = [
    alsa-lib
    libpulseaudio
    ncurses
    iniparser
    sndio
    SDL2
    libGL
    portaudio
    jack2
    pipewire
  ];

  propagatedBuildInputs = [
    fftw
  ];

  nativeBuildInputs = [
    autoreconfHook
    autoconf-archive
    pkgconf
    meson
    ninja
  ];

  preAutoreconf = ''
    echo ${version} > version
  '';
}
