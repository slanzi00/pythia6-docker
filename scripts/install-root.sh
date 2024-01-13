#!/bin/bash

git clone http://root.cern/git/root.git
mv root root-sources
mkdir root-install root-build
cd root-sources 
git checkout v6-31-01
cd ..
cmake -S root-sources -B root-build -DCMAKE_BUILD_TYPE=Release 
cmake --build root-build --target install -j3
source root-build/bin/thisroot.sh 