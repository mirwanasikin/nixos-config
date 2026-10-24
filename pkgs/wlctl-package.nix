{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  stdenv,
}:

rustPlatform.buildRustPackage rec {
  pname = "wlctl";
  version = "0.1.10";

  src = fetchFromGitHub {
    owner = "aashish-thapa";
    repo = pname;
    rev = "v${version}";
    sha256 = "1b3q0qmshv91rjz1fz2kg10xwk3aqkxrj5pqfc4bsb8ijvif3j3r";
  };

  cargoHash = "sha256-tuR0DmXuhkYVFpMuzRkIivBdH5YXvyQqz97LyaXAE8g=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "TUI for managing WiFi using NetworkManager";
    homepage = "https://github.com/aashish-thapa/wlctl";
    license = licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    platforms = platforms.linux;
  };
}