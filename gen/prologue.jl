# NIDAQmx Generator Prologue
# This file is included at the beginning of generated bindings

# Load the NIDAQmx library
const libnidaq = if Sys.iswindows()
    "nicaiu.dll"
elseif Sys.isapple()
    "/Library/Frameworks/nidaqmx.framework/nidaqmx"
else
    "libnidaqmx.so"
end

# Bool32 type for NIDAQmx boolean values
primitive type Bool32 <: Integer 32 end
Base.Bool(x::Bool32) = reinterpret(UInt32, x) != 0
Bool32(x::Bool) = reinterpret(Bool32, x ? UInt32(1) : UInt32(0))
Bool32(x::Integer) = reinterpret(Bool32, UInt32(x))
Base.show(io::IO, x::Bool32) = print(io, Bool(x) ? "TRUE" : "FALSE")

const bool32 = Bool32

# Handle types
const TaskHandle = Ptr{Cvoid}
const CalHandle = UInt32

# Callback function pointer types
const DAQmxEveryNSamplesEventCallbackPtr = Ptr{Cvoid}
const DAQmxDoneEventCallbackPtr = Ptr{Cvoid}
const DAQmxSignalEventCallbackPtr = Ptr{Cvoid}

# Type aliases matching NIDAQmx C types
const int8 = Int8
const uInt8 = UInt8
const int16 = Int16
const uInt16 = UInt16
const int32 = Int32
const uInt32 = UInt32
const int64 = Int64
const uInt64 = UInt64
const float32 = Float32
const float64 = Float64
