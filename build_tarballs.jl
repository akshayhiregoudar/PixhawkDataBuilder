using BinaryBuilder


name = "PixhawkData"
version = v"1.0"
# Collection of sources required to build PixhawkData
sources = [
    "https://github.com/akshayhiregoudar/PixhawkData/archive/master.tar.gz" =>
    "09e4ba02a129c651162600c118eae3b4f8d1490d49f193f961d0962f8d5c8482"
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/
cd PixhawkData-master/

make -j${nproc}
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libPixhawkData", :libPixhawkData),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
