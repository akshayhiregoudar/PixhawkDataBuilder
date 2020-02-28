using BinaryBuilder


name = "PixhawkData"
version = v"1.0.2"
# Collection of sources required to build PixhawkData
sources = [
    "https://github.com/akshayhiregoudar/PixhawkData.git" =>
    "e57a681e234f8feba7cd4eaa006112b74ba593e222fdc37361e8002d7198aeb1"
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/
cd PixhawkData

make
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
