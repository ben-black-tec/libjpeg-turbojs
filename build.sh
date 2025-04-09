#!/bin/sh
# rm -rf build
mkdir -p build
#(cd build && emconfigure cmake -DCMAKE_BUILD_TYPE=Debug ..) &&
emcc  -O3 -msse2 -msimd128  -c  \
            -I extern/libjpeg-turbo -I src \
         extern/libjpeg-turbo/turbojpeg.c \
         extern/libjpeg-turbo/jdapimin.c \
         extern/libjpeg-turbo/jcapimin.c \
         extern/libjpeg-turbo/jcapistd.c \
         extern/libjpeg-turbo/jdapistd.c \
         extern/libjpeg-turbo/jdatadst-tj.c \
         extern/libjpeg-turbo/jdatasrc-tj.c \
         extern/libjpeg-turbo/jerror.c \
         extern/libjpeg-turbo/jcparam.c \
         extern/libjpeg-turbo/jmemmgr.c \
         extern/libjpeg-turbo/jdmarker.c \
         extern/libjpeg-turbo/jdinput.c \
         extern/libjpeg-turbo/jcomapi.c \
         extern/libjpeg-turbo/jutils.c \
         extern/libjpeg-turbo/jmemnobs.c \
         extern/libjpeg-turbo/jdmaster.c \
         extern/libjpeg-turbo/cjpeg.c
em++ -O3 -msse2 -msimd128   -c \
         -I extern/libjpeg-turbo -I src \
         src/jslib.cpp -o jslib.o
echo "Objects finished"
em++ -O3 -msse2 -msimd128 -lembind --emit-tsd ./libjpegturbowasm.d.ts   \
       -O3           -msimd128           --bind        \
         -s MODULARIZE=1          -s EXPORT_NAME=libjpegturbowasm          -s DISABLE_EXCEPTION_CATCHING=1          -s ASSERTIONS=0          -s NO_EXIT_RUNTIME=1          -s MALLOC=emmalloc          -s ALLOW_MEMORY_GROWTH=1          -s TOTAL_MEMORY=1073741824          -s FILESYSTEM=0          -s EXPORTED_FUNCTIONS=[]          -s EXPORTED_RUNTIME_METHODS=[ccall]          -s EXPORT_ES6=1          -s EXPORT_NAME=instantiate    \
         -I extern/libjpeg-turbo -I src \
         jslib.o turbojpeg.o jdmaster.o jmemnobs.o jdapimin.o jutils.o jcomapi.o jdinput.o jdmarker.o jmemmgr.o jdapistd.o jcapimin.o jdatasrc-tj.o jcparam.o jerror.o jdatadst-tj.o jcapistd.o cjpeg.o -o libjpegturbowasm.js
# (cd build && emcmake cmake -DCMAKE_BUILD_TYPE=Release ..) &&
# (cd build && emmake make VERBOSE=1 -j 16) &&
cp ./build/src/libjpegturbowasm.js ./dist &&
cp ./build/src/libjpegturbowasm.d.ts ./dist &&
cp ./build/src/libjpegturbowasm.wasm ./dist #&&
#(cd test/node; npm run test)
