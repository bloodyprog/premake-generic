#!/bin/bash

for f in samples/*.lua
do
    build/premake5 generic --file=$f
done

build/premake5 gmake --file=build/premake5.lua --verbose

pushd build/gmake > /dev/null
make
popd > /dev/null
