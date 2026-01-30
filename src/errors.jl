# Error handling for DAQmx.jl

# Helper functions for pointer type conversions
# NI-DAQmx generated functions expect Ptr{Cchar} for strings
_cstr(s::String) = Ptr{Cchar}(pointer(s))
const NULLSTR = Ptr{Cchar}()

"""
    DAQmxError <: Exception

Exception thrown when a NI-DAQmx function returns a negative error code.

# Fields
- `code::Int32`: The NI-DAQmx error code (negative value).
- `message::String`: The human-readable error message from NI-DAQmx.
"""
struct DAQmxError <: Exception
    code::Int32
    message::String
end

function Base.showerror(io::IO, e::DAQmxError)
    print(io, "DAQmxError (", e.code, "): ", e.message)
end

"""
    DAQmxWarning

Represents a warning from NI-DAQmx (positive return code).
Warnings are logged but do not throw exceptions.

# Fields
- `code::Int32`: The NI-DAQmx warning code (positive value).
- `message::String`: The human-readable warning message from NI-DAQmx.
"""
struct DAQmxWarning
    code::Int32
    message::String
end

function Base.show(io::IO, w::DAQmxWarning)
    print(io, "DAQmxWarning (", w.code, "): ", w.message)
end

"""
    get_error_message(code::Int32) -> String

Retrieve the error message string for a given NI-DAQmx error or warning code.
"""
function get_error_message(code::Int32)
    # First call to get buffer size
    sz = DAQmxGetErrorString(code, NULLSTR, UInt32(0))
    sz <= 0 && return "Unknown error (code: $code)"

    # Allocate buffer and get message
    buffer = Vector{Int8}(undef, sz)
    DAQmxGetErrorString(code, pointer(buffer), UInt32(sz))

    # Convert to string, removing null terminator
    msg = unsafe_string(Ptr{UInt8}(pointer(buffer)))
    return msg
end

"""
    get_extended_error_info() -> String

Retrieve extended error information for the last error that occurred.
This provides more detailed context than `get_error_message`.
"""
function get_extended_error_info()
    # First call to get buffer size
    sz = DAQmxGetExtendedErrorInfo(NULLSTR, UInt32(0))
    sz <= 0 && return ""

    # Allocate buffer and get message
    buffer = Vector{Int8}(undef, sz)
    DAQmxGetExtendedErrorInfo(pointer(buffer), UInt32(sz))

    return unsafe_string(Ptr{UInt8}(pointer(buffer)))
end

"""
    check_error(code::Int32)

Check an NI-DAQmx return code and handle errors/warnings appropriately.

- If `code == 0`: Success, returns `nothing`.
- If `code > 0`: Warning, logs a warning message and returns `nothing`.
- If `code < 0`: Error, throws a `DAQmxError` exception.

# Arguments
- `code::Int32`: The return code from an NI-DAQmx function.

# Throws
- `DAQmxError`: If `code < 0`.
"""
function check_error(code::Int32)
    code == 0 && return nothing

    # Try to get error message, fall back to generic message if library unavailable
    message = try
        get_error_message(code)
    catch
        "NI-DAQmx error (code: $code)"
    end

    if code > 0
        # Warning - log and continue
        @warn "NI-DAQmx warning" code message
        return nothing
    else
        # Error - throw exception
        throw(DAQmxError(code, message))
    end
end

"""
    @check expr

Macro to check the return code of an NI-DAQmx function call.

# Example
```julia
@check DAQmxStartTask(task.handle)
```
"""
macro check(expr)
    quote
        check_error($(esc(expr)))
    end
end
