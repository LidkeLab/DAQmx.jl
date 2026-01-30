# Library loading and version detection for NIDAQmx

"""
    libnidaq

The path to the NIDAQmx shared library. Automatically detected based on the operating system.
"""
const libnidaq = if Sys.iswindows()
    "nicaiu.dll"
elseif Sys.isapple()
    "/Library/Frameworks/nidaqmx.framework/nidaqmx"
else
    "libnidaqmx.so"
end

"""
    DAQmxVersion

Holds the version information for the NIDAQmx driver.
"""
struct DAQmxVersion
    major::UInt32
    minor::UInt32
    update::UInt32
end

function Base.show(io::IO, v::DAQmxVersion)
    print(io, "NI-DAQmx v$(v.major).$(v.minor).$(v.update)")
end

Base.VersionNumber(v::DAQmxVersion) = VersionNumber(v.major, v.minor, v.update)

"""
    library_version() -> DAQmxVersion

Query the installed NIDAQmx driver version.

# Returns
- `DAQmxVersion`: The version of the installed NIDAQmx driver.

# Throws
- `NIDAQError`: If the version cannot be determined.

# Example
```julia
julia> v = library_version()
NIDAQmx v23.5.0

julia> VersionNumber(v)
v"23.5.0"
```
"""
function library_version()
    major = Ref{UInt32}(0)
    minor = Ref{UInt32}(0)
    update = Ref{UInt32}(0)

    @check DAQmxGetSysNIDAQMajorVersion(Base.unsafe_convert(Ptr{UInt32}, major))
    @check DAQmxGetSysNIDAQMinorVersion(Base.unsafe_convert(Ptr{UInt32}, minor))
    @check DAQmxGetSysNIDAQUpdateVersion(Base.unsafe_convert(Ptr{UInt32}, update))

    DAQmxVersion(major[], minor[], update[])
end

"""
    is_library_available() -> Bool

Check if the NIDAQmx library is available on the system.

# Returns
- `true` if the library can be loaded, `false` otherwise.
"""
function is_library_available()
    try
        # Try to load the library and call a simple function
        major = Ref{UInt32}(0)
        ccall((:DAQmxGetSysNIDAQMajorVersion, libnidaq), Int32, (Ptr{UInt32},), major)
        return true
    catch
        return false
    end
end

# Version information cached at module load time (if available)
const _cached_version = Ref{Union{Nothing, DAQmxVersion}}(nothing)

"""
    cached_library_version() -> Union{Nothing, DAQmxVersion}

Get the cached library version. Returns `nothing` if the library is not available.
This is populated at module load time.
"""
function cached_library_version()
    _cached_version[]
end

function __init_library__()
    if is_library_available()
        try
            _cached_version[] = library_version()
        catch
            _cached_version[] = nothing
        end
    else
        _cached_version[] = nothing
    end
end
