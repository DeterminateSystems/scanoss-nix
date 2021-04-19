{ lib
, stdenv
, fetchFromGitHub
, zlib
, openssl
, scanoss-ldb
}:
stdenv.mkDerivation rec {
  pname = "scanoss-engine";
  version = "4.1.5";

  src = fetchFromGitHub {
    owner = "scanoss";
    repo = "engine";
    rev = version;
    sha256 = "RTH0A/rwesgKGb86FIa1hDB4JWp/9RuRU8rGed5uAB4=";
  };

  NIX_CFLAGS_COMPILE = [
    # fix "error: format not a string literal and no format arguments"
    "-Wno-error=format-security"
  ];

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
    description = "An open, configurable OSS inventory engine";
    homepage = "https://github.com/scanoss/engine";
    license = licenses.gpl2Only;
  };
}
