{ pkgs, ... }:

let
  pname = "gridcraft";
  version = "0.14.2";

  src = pkgs.fetchurl {
    url = "https://github.com/storytold/gridcraft/releases/download/v${version}/gridcraft-${version}-linux-x86_64.deb";
    sha256 = "1ra0lwpi84zdlhz0dzmbm95ng38z3pwfh1911zfbnagb9pyv3qyx";
  };

  gridcraft-pkg = pkgs.stdenv.mkDerivation {
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
      wrapProgram $out/bin/gridcraft \
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
  home.packages = [ gridcraft-pkg ];
}