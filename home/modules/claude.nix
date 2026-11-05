{ pkgs, ... }:

let
  pname = "claude-desktop";
  version = "4.16336.0";

  src = pkgs.fetchurl {
    url = "https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_4.16336.0_amd64.deb";
    hash = "sha256-OBBzPpN5L3Dq6SEXXRPlPRzGvc6dwjEX8FiAh1IaZLw=";
  };

  claude-desktop-pkg = pkgs.stdenv.mkDerivation {
    inherit pname version src;

    nativeBuildInputs = with pkgs; [
      dpkg
      autoPatchelfHook
      makeWrapper
      wrapGAppsHook3
    ];

    buildInputs = with pkgs; [
      stdenv.cc.cc.lib
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      libdrm
      libnotify
      libpulseaudio
      libuuid
      libxkbcommon
      mesa
      nspr
      nss
      pango
      systemd
      vulkan-loader
      libx11
      libxscrnsaver
      libxcomposite
      libxcursor
      libxdamage
      libxext
      libxfixes
      libxi
      libxrandr
      libxrender
      libxtst
      libxcb
      libxshmfence
      wayland
      libGL
      libseccomp
      libcap_ng
      pipewire
    ];

    unpackPhase = ''
      runHook preUnpack
      dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner
      runHook postUnpack
    '';

    installPhase = ''
      mkdir -p $out
      if [ -d usr ]; then
        cp -r usr/* $out/
      fi
      if [ -d opt ]; then
        mkdir -p $out/opt
        cp -r opt/* $out/opt/
      fi
    '';


    postFixup = ''
      # Find the actual binary location (usually in opt/Claude/)
      for binary in $out/opt/Claude/claude $out/bin/claude; do
        if [ -f "$binary" ]; then
          wrapProgram "$binary" \
            --prefix LD_LIBRARY_PATH : ${
              pkgs.lib.makeLibraryPath (
                with pkgs;
                [
                  stdenv.cc.cc.lib
                  alsa-lib
                  at-spi2-atk
                  at-spi2-core
                  atk
                  cairo
                  cups
                  dbus
                  expat
                  fontconfig
                  freetype
                  gdk-pixbuf
                  glib
                  gtk3
                  libdrm
                  libnotify
                  libpulseaudio
                  libuuid
                  libxkbcommon
                  mesa
                  nspr
                  nss
                  pango
                  systemd
                  vulkan-loader
                  libx11
                  libxscrnsaver
                  libxcomposite
                  libxcursor
                  libxdamage
                  libxext
                  libxfixes
                  libxi
                  libxrandr
                  libxrender
                  libxtst
                  libxcb
                  libxshmfence
                  wayland
                  libGL
                  libseccomp
                  libcap_ng
                  pipewire
                ]
              )
            }
        fi
      done
    '';

    meta = with pkgs.lib; {
      description = "Claude Desktop - AI assistant from Anthropic";
      homepage = "https://claude.ai";
      platforms = [ "x86_64-linux" ];
    };
  };

in
{
  home.packages = [ claude-desktop-pkg ];
}
