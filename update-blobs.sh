#!/usr/bin/env bash

repository_url=https://github.com/borodust/base-blobs

if [[ -z  $1 ]] ; then
   echo "Version is not provided!"
   exit 1;
fi

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

platforms=("linux" "osx" "windows")

declare -A archs
archs=(["x86_64"]="x86_64" ["i686"]="x86")

for arch in "${!archs[@]}" ; do
    target_dir="$script_dir/${archs[$arch]}"
    mkdir -p "$target_dir"
    for platform in "${platforms[@]}" ; do
        archive_name=bodged-$arch-$platform-$1
        archive_path="$script_dir/$archive_name.zip"
        url="$repository_url/releases/download/$1/$archive_name.zip"
        echo "Downloading blob archive from $url"
        if ! wget -O $archive_path -q "$url" ; then
            echo "$lib download failed"
            exit 1
        else
            unzip $archive_path && \
            mv $script_dir/$archive_name/* $target_dir && \
            rm -rf $script_dir/$archive_name/ $archive_path
        fi
    done
done
