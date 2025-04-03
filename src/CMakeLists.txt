

   include_directories("../extern/libjpeg-turbo" "../build/extern/libjpeg-turbo")

   add_executable(libjpegturbowasm jslib.cpp)

   target_link_libraries(libjpegturbowasm PRIVATE turbojpeg-static)

   target_compile_features(libjpegturbowasm PUBLIC cxx_std_11)

   if (CMAKE_BUILD_TYPE STREQUAL Debug)
     SET(linkFlags "-g4")
   else() # Either MinSizeRel, RelWithDebInfo or Release, all which run with optimizations enabled.
     SET(linkFlags "-O3 -msse2 -msimd128 ")
   endif()

   set(CMAKE_CXX_FLAGS_RELEASE "-O3 -msse2 -msimd128 -lembind --emit-tsd ./libjpegturbowasm.d.ts")

   set_target_properties(
    libjpegturbowasm
       PROPERTIES
       LINK_FLAGS "\
         -O3  \
         -msimd128  \
         --bind \
         -s MODULARIZE=1 \
         -s EXPORT_NAME=libjpegturbowasm \
         -s DISABLE_EXCEPTION_CATCHING=1 \
         -s ASSERTIONS=0 \
         -s NO_EXIT_RUNTIME=1 \
         -s MALLOC=emmalloc \
         -s ALLOW_MEMORY_GROWTH=1 \
         -s TOTAL_MEMORY=1073741824 \
         -s FILESYSTEM=0 \
         -s EXPORTED_FUNCTIONS=[] \
         -s EXPORTED_RUNTIME_METHODS=[ccall] \
         -s EXPORT_ES6=1 \
         -s EXPORT_NAME=instantiate \
      ")
