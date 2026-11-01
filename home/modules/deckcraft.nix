{ pkgs, ... }:

let
  pname = "deckcraft";
  version = "0.13.1";

  src = pkgs.fetchurl {
    url = "https://github.com/storytold/deckcraft/releases/download/v${version}/deckcraft-${version}-linux-x86_64.deb";
    sha256 = "1mc5izvsdzwxxy10dm2b1zrqpayawi0m5gf90cqbb5yivxdc0vgj";
  };

  deckcraft-pkg = pkgs.stdenv.mkDerivation {
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
      alsa-lib
    ];

    unpackPhase = "dpkg -x $src .";

    installPhase = ''
      mkdir -p $out
      cp -r usr/* $out/
    '';

    postFixup = ''
      wrapProgram $out/bin/deckcraft \
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
              alsa-lib
            ]
          )
        }
    '';
  };

in
{
  home.packages = [ deckcraft-pkg ];
}