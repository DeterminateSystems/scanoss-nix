{ lib
, stdenv
, fetchFromGitHub
, zlib
, openssl
, scanoss-ldb
}:
stdenv.mkDerivation rec {
  pname = "scanoss-wayuu";
  version = "1.4.5";

  src = fetchFromGitHub {
    owner = "scanoss";
    repo = "wayuu";
    rev = "v${version}";
    sha256 = "4pDC0xgEQForEHj/G9mvn6x2fi4rO4B+N+niFAYWrXo=";
  };

  hardeningDisable = [
    # fix "error: ignoring return value of 'fread' declared with attribute
    # 'warn_unused_result'"
    "fortify"
  ];

  makeFlags = [
    # shared lib isn't built by default, so we need to specify an additional
    # target
    "slib"
  ];

  buildInputs = [
    zlib
    openssl
    scanoss-ldb
  ];

  preInstall = ''
    mkdir -p $out/lib $out/include
    sed "s@/usr/lib@$out/lib@" -i Makefile
    sed "s@/usr/include@$out/include@" -i Makefile
  '';

  meta = with lib; {
    description = "A blazing fast, lightweight web server and a microframework for building web applications and services";
    homepage = "https://github.com/scanoss/wayuu";
    license = licenses.gpl2Only;
  };
}
