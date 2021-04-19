{ lib
, stdenv
, fetchFromGitHub
, zlib
, openssl
}:
stdenv.mkDerivation rec {
  pname = "scanoss-ldb";
  version = "unstable-2021-03-22";

  src = fetchFromGitHub {
    owner = "scanoss";
    repo = "ldb";
    rev = "52faa8fd08ec0269c4e56be8e98e1dc5aae5102f";
    sha256 = "OE6DP+60gf1YVLSO+C1jNEz2XiW6URJ483Mi7yrPPqE=";
  };

  buildInputs = [
    zlib
    openssl
  ];

  preInstall = ''
    mkdir -p $out/bin $out/lib
    sed "s@/usr/bin@$out/bin@" -i Makefile
    sed "s@/usr/lib@$out/lib@" -i Makefile
  '';

  meta = with lib; {
    description = "A headless database management system focused in single-key, read-only application on vast amounts of data";
    homepage = "https://github.com/scanoss/ldb";
    license = licenses.gpl2Only;
  };
}
