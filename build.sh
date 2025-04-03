#!/bin/sh
# rm -rf build
mkdir -p build
#(cd build && emconfigure cmake -DCMAKE_BUILD_TYPE=Debug ..) &&
(cd build && emcmake cmake -DCMAKE_BUILD_TYPE=Release ..) &&
(cd build && emmake make VERBOSE=1 -j 16) &&
cp ./build/src/libjpegturbowasm.js ./dist &&
cp ./build/src/libjpegturbowasm.wasm ./dist &&
(cd test/node; npm run test)