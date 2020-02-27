using BinaryBuilder


name = "PixhawkData"
version = v"1.0"
# Collection of sources required to build PixhawkData
sources = [
    "https://github.com/akshayhiregoudar/PixhawkData/archive/v1.0.tar.gz" =>
    "42b306b99b3ab14bcb1ca34efb63c55e7a80e59a3b8e3cb70a9a7cb844944f7d"
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/
cd PixhawkData-1.0

make -j${nproc}

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
