# scanoss-nix

This repository packages SCANOSS's engine, LDB, minr tool, wayuu library, and
API.

Kept outside of Nixpkgs due to the number of components and niche use case.

You can build all packages with a simple `nix-build`, or a specific package,
like the minr tool, with `nix-build -A scanoss-minr`.

## Currently packaged

* [`scanoss-ldb`](https://github.com/scanoss/ldb)
* [`scanoss-engine`](https://github.com/scanoss/engine)
* [`scanoss-minr`](https://github.com/scanoss/minr)
* [`scanoss-wayuu`](https://github.com/scanoss/wayuu)
* [`scanoss-api`](https://github.com/scanoss/API)
