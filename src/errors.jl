# Error handling for NIDAQmx

# Helper functions for pointer type conversions
# NIDAQmx generated functions expect Ptr{Cchar} for strings
_cstr(s::String) = Ptr{Cchar}(pointer(s))
const NULLSTR = Ptr{Cchar}()

"""
    NIDAQError <: Exception

Exception thrown when a NIDAQmx function returns a negative error code.

# Fields
- `code::Int32`: The NIDAQmx error code (negative value).
- `message::String`: The human-readable error message from NIDAQmx.
"""
struct NIDAQError <: Exception
    code::Int32
    message::String
end

function Base.showerror(io::IO, e::NIDAQError)
    print(io, "NIDAQError (", e.code, "): ", e.message)
end

"""
    NIDAQWarning

Represents a warning from NIDAQmx (positive return code).
Warnings are logged but do not throw exceptions.

# Fields
- `code::Int32`: The NIDAQmx warning code (positive value).
- `message::String`: The human-readable warning message from NIDAQmx.
"""
struct NIDAQWarning
    code::Int32
    message::String
end

function Base.show(io::IO, w::NIDAQWarning)
    print(io, "NIDAQWarning (", w.code, "): ", w.message)
end

"""
    get_error_message(code::Int32) -> String

Retrieve the error message string for a given NIDAQmx error or warning code.
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

Check a NIDAQmx return code and handle errors/warnings appropriately.

- If `code == 0`: Success, returns `nothing`.
- If `code > 0`: Warning, logs a warning message and returns `nothing`.
- If `code < 0`: Error, throws a `NIDAQError` exception.

# Arguments
- `code::Int32`: The return code from a NIDAQmx function.

# Throws
- `NIDAQError`: If `code < 0`.
"""
function check_error(code::Int32)
    code == 0 && return nothing

    message = get_error_message(code)

    if code > 0
        # Warning - log and continue
        @warn "NIDAQmx warning" code message
        return nothing
    else
        # Error - throw exception
        throw(NIDAQError(code, message))
    end
end

"""
    @check expr

Macro to check the return code of a NIDAQmx function call.

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
