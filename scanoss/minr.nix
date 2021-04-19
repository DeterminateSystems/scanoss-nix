{ lib
, stdenv
, fetchFromGitHub
, zlib
, openssl
, scanoss-ldb
}:
stdenv.mkDerivation rec {
  pname = "scanoss-minr";
  version = "2.1.6";

  src = fetchFromGitHub {
    owner = "scanoss";
    repo = "minr";
    rev = version;
    sha256 = "fk9esVjlurPgmrzxLjZIyVLq7VQkf7bNAc1vFw2hyaQ=";
  };

  buildInputs = [
    zlib
    openssl
    scanoss-ldb
  ];

  preInstall = ''
    mkdir -p $out/bin
    sed "s@/usr/bin@$out/bin@" -i Makefile
  '';

  meta = with lib; {
    description = "A multi-purpose command line tool used for data mining";
    homepage = "https://github.com/scanoss/minr";
    license = licenses.gpl2Only;
  };
}
