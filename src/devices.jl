# Device enumeration and information for NIDAQmx.jl

"""
    Device

Represents a NI-DAQmx device.

# Fields
- `name::String`: The device name (e.g., "Dev1").
"""
struct Device
    name::String
end

function Base.show(io::IO, d::Device)
    print(io, "Device(\"$(d.name)\")")
end

"""
    devices() -> Vector{Device}

Get a list of all available NIDAQmx devices.

# Returns
- A vector of `Device` objects representing available devices.

# Example
```julia
julia> devs = devices()
2-element Vector{Device}:
 Device("Dev1")
 Device("Dev2")

julia> ai_channels(devs[1])
["Dev1/ai0", "Dev1/ai1", ...]
```
"""
function devices()
    # First call to get buffer size
    sz = DAQmxGetSysDevNames(Ptr{Int8}(), UInt32(0))
    sz <= 0 && return Device[]

    buffer = Vector{Int8}(undef, sz)
    @check DAQmxGetSysDevNames(pointer(buffer), UInt32(sz))

    names_str = unsafe_string(Ptr{UInt8}(pointer(buffer)))
    isempty(names_str) && return Device[]

    # Parse comma-separated device names
    names = filter(!isempty, String.(strip.(split(names_str, ","))))
    return Device.(names)
end

"""
    device_names() -> Vector{String}

Get a list of all available device names as strings.
"""
function device_names()
    return [d.name for d in devices()]
end

# ============================================================================
# Device Properties
# ============================================================================

"""
    product_type(device::Device) -> String
    product_type(device_name::String) -> String

Get the product type of a device (e.g., "USB-6001").
"""
function product_type(device::Device)
    product_type(device.name)
end

function product_type(device_name::String)
    # First call to get buffer size
    sz = DAQmxGetDevProductType(_cstr(device_name), Ptr{Int8}(), UInt32(0))
    sz <= 0 && return ""

    buffer = Vector{Int8}(undef, sz)
    @check DAQmxGetDevProductType(_cstr(device_name), pointer(buffer), UInt32(sz))
    return unsafe_string(Ptr{UInt8}(pointer(buffer)))
end

"""
    product_number(device::Device) -> UInt32
    product_number(device_name::String) -> UInt32

Get the product number of a device.
"""
function product_number(device::Device)
    product_number(device.name)
end

function product_number(device_name::String)
    num_ref = Ref{UInt32}(0)
    @check DAQmxGetDevProductNum(_cstr(device_name), Base.unsafe_convert(Ptr{UInt32}, num_ref))
    return num_ref[]
end

"""
    serial_number(device::Device) -> UInt32
    serial_number(device_name::String) -> UInt32

Get the serial number of a device.
"""
function serial_number(device::Device)
    serial_number(device.name)
end

function serial_number(device_name::String)
    num_ref = Ref{UInt32}(0)
    @check DAQmxGetDevSerialNum(_cstr(device_name), Base.unsafe_convert(Ptr{UInt32}, num_ref))
    return num_ref[]
end

"""
    is_simulated(device::Device) -> Bool
    is_simulated(device_name::String) -> Bool

Check if a device is a simulated device.
"""
function is_simulated(device::Device)
    is_simulated(device.name)
end

function is_simulated(device_name::String)
    sim_ref = Ref{Bool32}(0)
    @check DAQmxGetDevIsSimulated(_cstr(device_name), Base.unsafe_convert(Ptr{Bool32}, sim_ref))
    return Bool(sim_ref[])
end

# ============================================================================
# Channel Enumeration
# ============================================================================

function _get_string_list(getter_fn, device_name::String)
    # First call to get buffer size
    sz = getter_fn(_cstr(device_name), Ptr{Cchar}(), UInt32(0))
    sz <= 0 && return String[]

    buffer = Vector{Int8}(undef, sz)
    @check getter_fn(_cstr(device_name), pointer(buffer), UInt32(sz))

    channels_str = unsafe_string(Ptr{UInt8}(pointer(buffer)))
    isempty(channels_str) && return String[]

    return filter(!isempty, String.(strip.(split(channels_str, ","))))
end

"""
    ai_channels(device::Device) -> Vector{String}
    ai_channels(device_name::String) -> Vector{String}

Get a list of analog input physical channels available on the device.

# Example
```julia
julia> ai_channels("Dev1")
["Dev1/ai0", "Dev1/ai1", "Dev1/ai2", "Dev1/ai3"]
```
"""
ai_channels(device::Device) = ai_channels(device.name)
ai_channels(device_name::String) = _get_string_list(DAQmxGetDevAIPhysicalChans, device_name)

"""
    ao_channels(device::Device) -> Vector{String}
    ao_channels(device_name::String) -> Vector{String}

Get a list of analog output physical channels available on the device.
"""
ao_channels(device::Device) = ao_channels(device.name)
ao_channels(device_name::String) = _get_string_list(DAQmxGetDevAOPhysicalChans, device_name)

"""
    di_lines(device::Device) -> Vector{String}
    di_lines(device_name::String) -> Vector{String}

Get a list of digital input lines available on the device.
"""
di_lines(device::Device) = di_lines(device.name)
di_lines(device_name::String) = _get_string_list(DAQmxGetDevDILines, device_name)

"""
    do_lines(device::Device) -> Vector{String}
    do_lines(device_name::String) -> Vector{String}

Get a list of digital output lines available on the device.
"""
do_lines(device::Device) = do_lines(device.name)
do_lines(device_name::String) = _get_string_list(DAQmxGetDevDOLines, device_name)

"""
    di_ports(device::Device) -> Vector{String}
    di_ports(device_name::String) -> Vector{String}

Get a list of digital input ports available on the device.
"""
di_ports(device::Device) = di_ports(device.name)
di_ports(device_name::String) = _get_string_list(DAQmxGetDevDIPorts, device_name)

"""
    do_ports(device::Device) -> Vector{String}
    do_ports(device_name::String) -> Vector{String}

Get a list of digital output ports available on the device.
"""
do_ports(device::Device) = do_ports(device.name)
do_ports(device_name::String) = _get_string_list(DAQmxGetDevDOPorts, device_name)

"""
    ci_channels(device::Device) -> Vector{String}
    ci_channels(device_name::String) -> Vector{String}

Get a list of counter input physical channels available on the device.
"""
ci_channels(device::Device) = ci_channels(device.name)
ci_channels(device_name::String) = _get_string_list(DAQmxGetDevCIPhysicalChans, device_name)

"""
    co_channels(device::Device) -> Vector{String}
    co_channels(device_name::String) -> Vector{String}

Get a list of counter output physical channels available on the device.
"""
co_channels(device::Device) = co_channels(device.name)
co_channels(device_name::String) = _get_string_list(DAQmxGetDevCOPhysicalChans, device_name)

"""
    terminals(device::Device) -> Vector{String}
    terminals(device_name::String) -> Vector{String}

Get a list of terminals available on the device.
"""
terminals(device::Device) = terminals(device.name)
terminals(device_name::String) = _get_string_list(DAQmxGetDevTerminals, device_name)

# ============================================================================
# Voltage/Current Ranges
# ============================================================================

function _get_ranges(getter_fn, device_name::String)
    # First call to get buffer size (returns number of elements)
    sz = getter_fn(_cstr(device_name), Ptr{Float64}(), UInt32(0))
    sz <= 0 && return Matrix{Float64}(undef, 0, 2)

    data = Vector{Float64}(undef, sz)
    @check getter_fn(_cstr(device_name), pointer(data), UInt32(sz))

    # Reshape into min/max pairs (collect to get Matrix, not Adjoint)
    n_ranges = div(sz, 2)
    return collect(reshape(data, (2, n_ranges))')
end

"""
    ai_voltage_ranges(device::Device) -> Matrix{Float64}
    ai_voltage_ranges(device_name::String) -> Matrix{Float64}

Get the available voltage ranges for analog input channels.

# Returns
- A matrix where each row is [min, max] for a voltage range.

# Example
```julia
julia> ai_voltage_ranges("Dev1")
4×2 Matrix{Float64}:
 -10.0  10.0
  -5.0   5.0
  -1.0   1.0
  -0.2   0.2
```
"""
ai_voltage_ranges(device::Device) = ai_voltage_ranges(device.name)
ai_voltage_ranges(device_name::String) = _get_ranges(DAQmxGetDevAIVoltageRngs, device_name)

"""
    ao_voltage_ranges(device::Device) -> Matrix{Float64}
    ao_voltage_ranges(device_name::String) -> Matrix{Float64}

Get the available voltage ranges for analog output channels.
"""
ao_voltage_ranges(device::Device) = ao_voltage_ranges(device.name)
ao_voltage_ranges(device_name::String) = _get_ranges(DAQmxGetDevAOVoltageRngs, device_name)

"""
    ai_current_ranges(device::Device) -> Matrix{Float64}
    ai_current_ranges(device_name::String) -> Matrix{Float64}

Get the available current ranges for analog input channels.
"""
ai_current_ranges(device::Device) = ai_current_ranges(device.name)
ai_current_ranges(device_name::String) = _get_ranges(DAQmxGetDevAICurrentRngs, device_name)

"""
    ao_current_ranges(device::Device) -> Matrix{Float64}
    ao_current_ranges(device_name::String) -> Matrix{Float64}

Get the available current ranges for analog output channels.
"""
ao_current_ranges(device::Device) = ao_current_ranges(device.name)
ao_current_ranges(device_name::String) = _get_ranges(DAQmxGetDevAOCurrentRngs, device_name)

# ============================================================================
# Device Control
# ============================================================================

"""
    self_calibrate!(device::Device)
    self_calibrate!(device_name::String)

Perform self-calibration on the device.
"""
self_calibrate!(device::Device) = self_calibrate!(device.name)
function self_calibrate!(device_name::String)
    @check DAQmxSelfCal(_cstr(device_name))
    return nothing
end

"""
    reset!(device::Device)
    reset!(device_name::String)

Reset the device to its default state.
"""
reset!(device::Device) = reset!(device.name)
function reset!(device_name::String)
    @check DAQmxResetDevice(_cstr(device_name))
    return nothing
end
