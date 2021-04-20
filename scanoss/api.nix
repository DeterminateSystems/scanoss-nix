{ lib
, stdenv
, fetchFromGitHub
, scanoss-engine
, openssl
, scanoss-wayuu
}:
stdenv.mkDerivation rec {
  pname = "scanoss-api";
  version = "1.5";

  src = fetchFromGitHub {
    owner = "scanoss";
    repo = "API";
    rev = version;
    sha256 = "bYDSK6QkaH57B0wz33i4c21IvfaVid4d1FZLx0JT/2Y=";
  };

  preBuild = ''
    sed "s@/usr/bin/scanoss@${scanoss-engine}/bin/scanoss@" -i src/scan_direct.h
  '';

  buildInputs = [
    openssl
    scanoss-wayuu
  ];

  preInstall = ''
    mkdir -p $out/bin
    sed "s@/usr/bin@$out/bin@" -i Makefile
  '';

  meta = with lib; {
    description = "The SCANOSS API";
    homepage = "https://github.com/scanoss/API";
    license = licenses.gpl2Only;
  };
}
