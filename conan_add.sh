#!/bin/bash
#echo $1
#echo $2
#echo $3
#echo $4
cd ./recipes/
PKG="$1" VER="$2" && \
    conan export ./$PKG/$3 $PKG/$VER@local/stable && \
    conan create $PKG/$4 $PKG/$VER@local/stable # && \
    #conan upload "$PKG*" --all -r local -c --force
