{ pkgs, ... }:

let
  pname = "wordcraft";
  version = "0.13.2";

  src = pkgs.fetchurl {
    url = "https://github.com/storytold/wordcraft/releases/download/v${version}/wordcraft-${version}-linux-x86_64.deb";
    sha256 = "0s6c12914rlv9aczlyjdhahqzmhp40k68vzxdh8llpjd7v2gakwb";
  };

  wordcraft-pkg = pkgs.stdenv.mkDerivation {
    inherit pname version src;
    nativeBuildInputs = with pkgs; [
      dpkg
      autoPatchelfHook
      makeWrapper
    ];
    buildInputs = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      fontconfig
      freetype
      libx11
      libxcursor
      libxi
      libxrandr
      libxkbcommon
      wayland
      vulkan-loader
      libGL
      dbus
      zenity
      gtk3
    ];

    unpackPhase = "dpkg -x $src .";

    installPhase = ''
      mkdir -p $out
      cp -r usr/* $out/
    '';

    postFixup = ''
      wrapProgram $out/bin/wordcraft \
        --prefix LD_LIBRARY_PATH : ${
          pkgs.lib.makeLibraryPath (
            with pkgs;
            [
              libx11
              libxcursor
              libxi
              libxrandr
              wayland
              libxkbcommon
              vulkan-loader
              libGL
              dbus
              zenity
              gtk3
            ]
          )
        }
    '';
  };

in
{
  home.packages = [ wordcraft-pkg ];
}
