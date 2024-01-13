#!/bin/bash

cd ${ROOT_BUILD_DIR}
wget https://pythia.org/download/pythia81/pythia8186.tgz
tar zxvf pythia8186.tgz && rm -rf pythia8186.tgz
cd pythia8186
./configure --enable-shared --enable-64bit
make -j3