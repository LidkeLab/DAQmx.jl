# Auto-generated type definitions for NI-DAQmx
# Do not edit manually - regenerate using gen/generator.jl

# Basic numeric type aliases matching NI-DAQmx C types
const int8 = Int8
const uInt8 = Cuchar
const int16 = Cshort
const uInt16 = Cushort
const int32 = Cint
const uInt32 = Cuint
const float32 = Cfloat
const float64 = Cdouble
const int64 = Clonglong
const uInt64 = Culonglong

# String type for NI-DAQmx (varies by platform)
const dType = Cchar

# Bool32 as a proper Julia type
primitive type Bool32 <: Integer 32 end
Base.Bool(x::Bool32) = reinterpret(UInt32, x) != 0
Bool32(x::Bool) = reinterpret(Bool32, x ? UInt32(1) : UInt32(0))
Bool32(x::Integer) = reinterpret(Bool32, UInt32(x))
Base.show(io::IO, x::Bool32) = print(io, Bool(x) ? "TRUE" : "FALSE")

const bool32 = Bool32

# Handle types
const TaskHandle = Ptr{Cvoid}
const CalHandle = uInt32

# Callback function pointer types
const DAQmxEveryNSamplesEventCallbackPtr = Ptr{Cvoid}
const DAQmxDoneEventCallbackPtr = Ptr{Cvoid}
const DAQmxSignalEventCallbackPtr = Ptr{Cvoid}

# Time structures
struct CVITime
    lsb::uInt32
    msb::int64
end

struct CVIAbsoluteTime
    cviTime::CVITime
end

# Common constants
const DAQmx_TRUE = Bool32(1)
const DAQmx_FALSE = Bool32(0)
