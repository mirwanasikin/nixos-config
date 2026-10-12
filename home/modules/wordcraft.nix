{ pkgs, ... }:

let
  pname = "wordcraft";
  version = "0.5.0";

  src = pkgs.fetchurl {
    url = "https://github.com/storytold/wordcraft/releases/download/v${version}/wordcraft-${version}-linux-x86_64.deb";
    sha256 = "1cjx5qfhczwc1i4qak0z2idgsf6v1bb5pvy7177pw2a6p3rkqd7x";
  };

  wordcraft-pkg = pkgs.stdenv.mkDerivation {
    inherit pname version src;
    nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook makeWrapper ];
    buildInputs = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      fontconfig
      freetype
      libx11
      libX11
      libXcursor
      libXi
      libXrandr
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
        --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath (with pkgs; [
          wayland
          libxkbcommon
          vulkan-loader
          libGL
          dbus
          zenity
          gtk3
        ])}
    '';
  };

in
{
  home.packages = [ wordcraft-pkg ];
}
