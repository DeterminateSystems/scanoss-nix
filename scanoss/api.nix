{ lib
, stdenv
, fetchFromGitHub
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
