using BinaryBuilder

# Collection of sources required to build PixhawkData
sources = [
    "https://github.com/akshayhiregoudar/pixhawk_sensor_data/releases/download/v1.0.1/pixhawk_sensor_data-1.0.1.tar.gz" =>
    "88dacd85a05c690f238212e126efd76b0c8792e79ebaff9690431de6ed6ded7c"
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd pixhawk_sensor_data-1.0.1

if [[ "${target}" == *-freebsd* ]] || [[ "${target}" == *-apple-* ]]; then
    export FC=/opt/${target}/bin/${target}-gfortran
    export LD=/opt/${target}/bin/${target}-ld
    export AR=/opt/${target}/bin/${target}-ar
    export AS=/opt/${target}/bin/${target}-as
    export NM=/opt/${target}/bin/${target}-nm
    export OBJDUMP=/opt/${target}/bin/${target}-objdump
fi
./configure --prefix=$prefix --host=${target} --disable-python
make -j${nproc}
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    #Linux(:x86_64, compiler_abi=CompilerABI(:gcc7)),
    Linux(:x86_64, compiler_abi=CompilerABI(:gcc8)),
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libPixhawkData", :libPixhawkData),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "PixhawkData", v"1.0.1", sources, script, platforms, products, dependencies)
