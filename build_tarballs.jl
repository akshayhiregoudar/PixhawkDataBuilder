using BinaryBuilder

# Collection of sources required to build PixhawkData
sources = [
    "https://github.com/akshayhiregoudar/pixhawk_sensor_data.git" =>
    "fe95426aa216dee8b52cc858036ae9a4e6f49bb8"

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/
cd pixhawk_sensor_data
"""


# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc7)),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc8)),
    Linux(:x86_64, compiler_abi=CompilerABI(:gcc7)),
    Linux(:x86_64, compiler_abi=CompilerABI(:gcc8)),
    MacOS()
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libPixhawkData", :libPixhawkData),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "xsum", v"1.0", sources, script, platforms, products, dependencies)
