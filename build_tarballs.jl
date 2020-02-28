using BinaryBuilder


name = "PixhawkData"
version = v"1.0.2"
# Collection of sources required to build PixhawkData
sources = [
    "https://github.com/akshayhiregoudar/PixhawkData/archive/v1.0.2.tar.gz" =>
    "e57a681e234f8feba7cd4eaa006112b74ba593e222fdc37361e8002d7198aeb1"
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/
cd PixhawkData-1.0.2

if [[ "${target}" == *-mingw* ]]; then
    sed -i 's/cross_compiling=no/cross_compiling=yes/' configure
    ./configure --prefix=$prefix --target=${target} --build=x86_64-w64-mingw32 --enable-silent-rules --enable-shared --enable-obj
elif [[ "${target}" == *-apple-* ]]; then
    sed -i 's/cross_compiling=no/cross_compiling=yes/' configure
    export CC=/opt/${target}/bin/${target}-gcc
    export CXX=/opt/${target}/bin/${target}-g++
    ./configure --prefix=$prefix --target=${target} --enable-silent-rules --enable-shared --enable-obj
else
    autoreconf -fi
    sed -i 's/cross_compiling=no/cross_compiling=yes/' configure
    export CC=/opt/${target}/bin/${target}-gcc
    export CXX=/opt/${target}/bin/${target}-g++
    export LD=/opt/${target}/bin/${target}-ld
    export LDFLAGS=-L/opt/${target}/${target}/lib64
    ./configure --prefix=$prefix --target=${target} --enable-silent-rules --enable-shared --enable-obj
fi
make -j${nproc} check
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc),
    MacOS(:x86_64),
    Windows(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libPixhawkData", :libPixhawkData),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
