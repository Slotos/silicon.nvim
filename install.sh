#!/usr/bin/env bash

set -e

get_latest_release() {
  curl --silent "https://api.github.com/repos/krivahtoo/silicon.nvim/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' # Pluck JSON value
}

# download the silicon.nvim (of the specified version) from Releases
download() {
  echo "Downloading silicon.nvim library: " $1
  if [ "$(uname)" == "Darwin" ]; then
    curl -fsSL https://github.com/krivahtoo/silicon.nvim/releases/download/$1/silicon-mac.tar.gz --output silicon-mac.tar.gz
    tar -xaf silicon-mac.tar.gz
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    curl -fsSL https://github.com/krivahtoo/silicon.nvim/releases/download/$1/silicon-linux.tar.gz --output silicon-linux.tar.gz
    tar -xaf silicon-linux.tar.gz
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    curl -fsSL https://github.com/krivahtoo/silicon.nvim/releases/download/$1/silicon-win.zip --output silicon-win.zip
    unzip silicon-win.zip
  fi
}

case "$1" in
  build)
    echo "Building silicon.nvim from source..."

    cargo build --release 

    # Place the compiled library where Neovim can find it.
    mkdir -p lua

    if [ "$(uname)" == "Darwin" ]; then
        mv target/release/libsilicon.dylib lua/silicon.so
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        mv target/release/libsilicon.so lua/silicon.so
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
        mv target/release/silicon.dll lua/silicon.dll
    fi
    ;;
  *)
    version=$(get_latest_release)
    download $version

    ;;
esac
