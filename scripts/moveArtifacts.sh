#!/bin/sh
set -e

chmod +x binaries-*/*.exe

mv binaries-darwin/* darwin
mv binaries-linux/* linux
mv binaries-win32/* win32

rmdir binaries-*

mv lib-ocaml lib/ocaml
