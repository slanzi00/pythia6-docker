#!/bin/bash

cd ${ROOT_BUILD_DIR}
cmake -DCMAKE_INSTALL_PREFIX=${ROOT_INSTALL_DIR} -DPYTHIA8_DIR=${PYTHIA8} \
      -DPYTHIA8_INCLUDE_DIR=${PYTHIA8}/include \
      -DPYTHIA8_LIBRARY=${PYTHIA8}/lib/libpythia8.so \
      -DPYTHIA6_LIBRARY=${PYTHIA6}/libPythia6.so -DGSL_DIR=/usr/local \
      -Dbuiltin_xrootd=ON -Droofit=ON -Dpythia8=ON -Dpythia6=ON ${ROOT_SOURCE_DIR}
cmake --build ${ROOT_BUILD_DIR} --target install -j3