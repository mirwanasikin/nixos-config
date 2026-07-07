{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;

let
  libs = [
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    curl
    dbus
    expat
    glib
    gtk3
    mesa
    nspr
    nss
    pango
    systemd
    vulkan-loader
    libxkbcommon
    libdrm
    libxshmfence

    libX11
    libxcb
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
  ];
in

stdenv.mkDerivation rec {
  pname = "brave-origin-nightly";
  version = "1.94.40";

  src = fetchurl {
    url = "https://brave-browser-apt-nightly.s3.brave.com/pool/main/b/brave-origin-nightly/brave-origin-nightly_${version}_amd64.deb";

    hash = "sha256-40ydFhbnjyGsGBducRnxK4XwrD4lYew7tkppalDo3QM=";
  };

  sourceRoot = ".";

  autoPatchelfIgnoreMissingDeps = [
    "libQt5Core.so.5"
    "libQt5Gui.so.5"
    "libQt5Widgets.so.5"

    "libQt6Core.so.6"
    "libQt6Gui.so.6"
    "libQt6Widgets.so.6"
  ];

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    wrapGAppsHook3
    makeWrapper
  ];

  buildInputs = libs;

  unpackPhase = ''
    runHook preUnpack

    ar x "$src"
    tar --no-same-owner --no-same-permissions -xf data.tar.xz

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt
    cp -r opt/brave.com $out/opt/

    mkdir -p $out/share
    cp -r usr/share/* $out/share/

    mkdir -p $out/bin

    ln -s \
      $out/opt/brave.com/brave-origin-nightly/brave-origin-nightly \
      $out/bin/brave-origin-nightly

    mkdir -p $out/share/pixmaps

    cp \
      opt/brave.com/brave-origin-nightly/product_logo_256_nightly.png \
      $out/share/pixmaps/brave-origin-nightly.png

        runHook postInstall
  '';

  postInstall = ''
    for f in $out/share/applications/*.desktop; do
      substituteInPlace "$f" \
        --replace-fail "/usr/bin/brave-origin-nightly" \
                       "$out/bin/brave-origin-nightly"
    done
  '';

  postFixup = ''
    wrapProgram $out/bin/brave-origin-nightly \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath libs}"
  '';

  meta = with lib; {
    description = "Brave Origin Nightly Browser";
    homepage = "https://brave.com/origin/";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "brave-origin-nightly";

    sourceProvenance = with sourceTypes; [
      binaryNativeCode
    ];
  };
}
