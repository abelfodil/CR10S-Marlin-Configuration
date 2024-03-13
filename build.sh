#!/usr/bin/env bash

source_dir=$(pushd $(dirname $0) >/dev/null && pwd && popd >/dev/null)

docker build $source_dir -o $source_dir
