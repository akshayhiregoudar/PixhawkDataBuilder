using BinaryBuilder


name = "PixhawkData"
version = v"1.0.2"
# Collection of sources required to build PixhawkData
sources = [
    "https://github.com/akshayhiregoudar/pixhawk_sensor_data/archive/v1.0.2.tar.gz" =>
    "e52c064061d9e35f4808a67f7d516047b015fefa0df2ac017b99bbe9afb03402"
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/
cd pixhawk_sensor_data-1.0.2/

git init
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
