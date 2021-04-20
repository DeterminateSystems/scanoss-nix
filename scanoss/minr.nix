{ lib
, stdenv
, fetchFromGitHub
, gzip
, gnutar
, p7zip
, curl
, coreutils
, unrar
, unzip
, xz
, ruby
, makeWrapper
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

  preBuild = ''
    sed -i src/minr.c \
      -e "s@/bin/gunzip@${gzip}/bin/gunzip@" \
      -e "s@/bin/tar@${gnutar}/bin/tar@" \
      -e "s@/usr/bin/7z@${p7zip}/bin/7z@" \
      -e "s@/usr/bin/curl@${curl}/bin/curl@" \
      -e "s@/usr/bin/sort@${coreutils}/bin/sort@" \
      -e "s@/usr/bin/unrar@${unrar}/bin/unrar@" \
      -e "s@/usr/bin/unzip@${unzip}/bin/unzip@" \
      -e "s@/usr/bin/xz@${xz}/bin/xz@" \
      -e "s@/usr/bin/gem@${ruby}/bin/gem@"
  '';

  nativeBuildInputs = [
    makeWrapper
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

  postFixup = ''
    wrapProgram $out/bin/minr \
      --prefix PATH : ${lib.makeBinPath [ gzip gnutar p7zip curl coreutils unrar unzip xz ruby ]}
  '';

  meta = with lib; {
    description = "A multi-purpose command line tool used for data mining";
    homepage = "https://github.com/scanoss/minr";
    license = licenses.gpl2Only;
  };
}
