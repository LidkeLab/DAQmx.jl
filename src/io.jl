# Read/Write operations for NIDAQmx.jl

# ============================================================================
# Analog Input Read
# ============================================================================

"""
    read(task::AITask; samples_per_channel::Int=-1, timeout::Float64=10.0,
         fill_mode::FillMode=GroupByChannel) -> Matrix{Float64}

Read analog data from an analog input task.

# Arguments
- `task::AITask`: The analog input task.

# Keyword Arguments
- `samples_per_channel::Int`: Number of samples per channel to read.
  Use -1 to read all available samples (default: -1).
- `timeout::Float64`: Timeout in seconds (default: 10.0). Use -1.0 for infinite.
- `fill_mode::FillMode`: Data layout (`GroupByChannel` or `GroupByScanNumber`).

# Returns
- `Vector{Float64}` if single channel, `Matrix{Float64}` if multiple channels.
  For `GroupByChannel`: columns are channels, rows are samples.

# Example
```julia
task = AITask("Dev1/ai0:1")
configure_timing!(task; rate=1000.0, samples_per_channel=100)
start!(task)
data = read(task; samples_per_channel=100)  # 100×2 Matrix
stop!(task)
```
"""
function Base.read(task::AITask;
                   samples_per_channel::Int=-1,
                   timeout::Float64=10.0,
                   fill_mode::FillMode=GroupByChannel)
    _read_analog(task, Float64, samples_per_channel, timeout, fill_mode)
end

"""
    read(task::AITask, ::Type{T}; kwargs...) where T

Read analog data with a specific precision type.
Supported types: `Float64`, `Int16`, `UInt16`, `Int32`, `UInt32`.
"""
function Base.read(task::AITask, ::Type{T};
                   samples_per_channel::Int=-1,
                   timeout::Float64=10.0,
                   fill_mode::FillMode=GroupByChannel) where T<:Union{Float64, Int16, UInt16, Int32, UInt32}
    _read_analog(task, T, samples_per_channel, timeout, fill_mode)
end

function _read_analog(task::AITask, ::Type{Float64}, samples_per_channel::Int, timeout::Float64, fill_mode::FillMode)
    n_chans = num_channels(task)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{Float64}(undef, buffer_size * n_chans)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadAnalogF64(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        Bool32(fill_mode),
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    actual_samples = samples_read[]
    data = data[1:actual_samples * n_chans]

    if n_chans == 1
        return data
    else
        return reshape(data, (actual_samples, n_chans))
    end
end

function _read_analog(task::AITask, ::Type{Int16}, samples_per_channel::Int, timeout::Float64, fill_mode::FillMode)
    n_chans = num_channels(task)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{Int16}(undef, buffer_size * n_chans)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadBinaryI16(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        Bool32(fill_mode),
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    actual_samples = samples_read[]
    data = data[1:actual_samples * n_chans]

    if n_chans == 1
        return data
    else
        return reshape(data, (actual_samples, n_chans))
    end
end

function _read_analog(task::AITask, ::Type{UInt16}, samples_per_channel::Int, timeout::Float64, fill_mode::FillMode)
    n_chans = num_channels(task)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{UInt16}(undef, buffer_size * n_chans)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadBinaryU16(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        Bool32(fill_mode),
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    actual_samples = samples_read[]
    data = data[1:actual_samples * n_chans]

    if n_chans == 1
        return data
    else
        return reshape(data, (actual_samples, n_chans))
    end
end

function _read_analog(task::AITask, ::Type{Int32}, samples_per_channel::Int, timeout::Float64, fill_mode::FillMode)
    n_chans = num_channels(task)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{Int32}(undef, buffer_size * n_chans)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadBinaryI32(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        Bool32(fill_mode),
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    actual_samples = samples_read[]
    data = data[1:actual_samples * n_chans]

    if n_chans == 1
        return data
    else
        return reshape(data, (actual_samples, n_chans))
    end
end

function _read_analog(task::AITask, ::Type{UInt32}, samples_per_channel::Int, timeout::Float64, fill_mode::FillMode)
    n_chans = num_channels(task)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{UInt32}(undef, buffer_size * n_chans)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadBinaryU32(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        Bool32(fill_mode),
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    actual_samples = samples_read[]
    data = data[1:actual_samples * n_chans]

    if n_chans == 1
        return data
    else
        return reshape(data, (actual_samples, n_chans))
    end
end

"""
    read_scalar(task::AITask; timeout::Float64=10.0) -> Float64

Read a single sample from an analog input task.
"""
function read_scalar(task::AITask; timeout::Float64=10.0)
    value = Ref{Float64}(0.0)
    @check DAQmxReadAnalogScalarF64(task.handle, timeout, Base.unsafe_convert(Ptr{Float64}, value), Ptr{Bool32}())
    return value[]
end

# ============================================================================
# Digital Input Read
# ============================================================================

"""
    read(task::DITask; samples_per_channel::Int=-1, timeout::Float64=10.0,
         fill_mode::FillMode=GroupByChannel) -> Array{UInt32}

Read digital data from a digital input task.

# Returns
- `Vector{UInt32}` if single channel, `Matrix{UInt32}` if multiple channels.
"""
function Base.read(task::DITask;
                   samples_per_channel::Int=-1,
                   timeout::Float64=10.0,
                   fill_mode::FillMode=GroupByChannel)
    _read_digital(task, UInt32, samples_per_channel, timeout, fill_mode)
end

"""
    read(task::DITask, ::Type{T}; kwargs...) where T

Read digital data with a specific type. Supported: `UInt8`, `UInt16`, `UInt32`.
"""
function Base.read(task::DITask, ::Type{T};
                   samples_per_channel::Int=-1,
                   timeout::Float64=10.0,
                   fill_mode::FillMode=GroupByChannel) where T<:Union{UInt8, UInt16, UInt32}
    _read_digital(task, T, samples_per_channel, timeout, fill_mode)
end

function _read_digital(task::DITask, ::Type{UInt8}, samples_per_channel::Int, timeout::Float64, fill_mode::FillMode)
    n_chans = num_channels(task)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{UInt8}(undef, buffer_size * n_chans)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadDigitalU8(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        Bool32(fill_mode),
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    actual_samples = samples_read[]
    data = data[1:actual_samples * n_chans]

    if n_chans == 1
        return data
    else
        return reshape(data, (actual_samples, n_chans))
    end
end

function _read_digital(task::DITask, ::Type{UInt16}, samples_per_channel::Int, timeout::Float64, fill_mode::FillMode)
    n_chans = num_channels(task)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{UInt16}(undef, buffer_size * n_chans)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadDigitalU16(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        Bool32(fill_mode),
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    actual_samples = samples_read[]
    data = data[1:actual_samples * n_chans]

    if n_chans == 1
        return data
    else
        return reshape(data, (actual_samples, n_chans))
    end
end

function _read_digital(task::DITask, ::Type{UInt32}, samples_per_channel::Int, timeout::Float64, fill_mode::FillMode)
    n_chans = num_channels(task)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{UInt32}(undef, buffer_size * n_chans)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadDigitalU32(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        Bool32(fill_mode),
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    actual_samples = samples_read[]
    data = data[1:actual_samples * n_chans]

    if n_chans == 1
        return data
    else
        return reshape(data, (actual_samples, n_chans))
    end
end

"""
    read_scalar(task::DITask; timeout::Float64=10.0) -> UInt32

Read a single digital sample.
"""
function read_scalar(task::DITask; timeout::Float64=10.0)
    value = Ref{UInt32}(0)
    @check DAQmxReadDigitalScalarU32(task.handle, timeout, Base.unsafe_convert(Ptr{UInt32}, value), Ptr{Bool32}())
    return value[]
end

# ============================================================================
# Counter Input Read
# ============================================================================

"""
    read(task::CITask; samples_per_channel::Int=-1, timeout::Float64=10.0) -> Vector

Read counter data from a counter input task.
"""
function Base.read(task::CITask;
                   samples_per_channel::Int=-1,
                   timeout::Float64=10.0)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{UInt32}(undef, buffer_size)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadCounterU32(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    return data[1:samples_read[]]
end

"""
    read(task::CITask, ::Type{Float64}; samples_per_channel::Int=-1, timeout::Float64=10.0) -> Vector{Float64}

Read counter data as floating point values.
"""
function Base.read(task::CITask, ::Type{Float64};
                   samples_per_channel::Int=-1,
                   timeout::Float64=10.0)
    buffer_size = samples_per_channel == -1 ? 1024 : samples_per_channel
    data = Vector{Float64}(undef, buffer_size)
    samples_read = Ref{Int32}(0)

    @check DAQmxReadCounterF64(
        task.handle,
        Int32(samples_per_channel),
        timeout,
        pointer(data),
        UInt32(length(data)),
        Base.unsafe_convert(Ptr{Int32}, samples_read),
        Ptr{Bool32}()
    )

    return data[1:samples_read[]]
end

"""
    read_scalar(task::CITask; timeout::Float64=10.0) -> UInt32

Read a single counter value.
"""
function read_scalar(task::CITask; timeout::Float64=10.0)
    value = Ref{UInt32}(0)
    @check DAQmxReadCounterScalarU32(task.handle, timeout, Base.unsafe_convert(Ptr{UInt32}, value), Ptr{Bool32}())
    return value[]
end

# ============================================================================
# Analog Output Write
# ============================================================================

"""
    write(task::AOTask, data::AbstractArray{Float64};
          auto_start::Bool=true, timeout::Float64=10.0,
          data_layout::FillMode=GroupByChannel) -> Int

Write analog data to an analog output task.

# Arguments
- `task::AOTask`: The analog output task.
- `data::AbstractArray{Float64}`: Data to write. For multiple channels, use a matrix
  where rows are samples and columns are channels (with `GroupByChannel`).

# Keyword Arguments
- `auto_start::Bool`: Automatically start the task (default: true).
- `timeout::Float64`: Timeout in seconds (default: 10.0).
- `data_layout::FillMode`: Data layout in the array.

# Returns
- Number of samples per channel written.

# Example
```julia
task = AOTask("Dev1/ao0")
configure_timing!(task; rate=1000.0, samples_per_channel=100)
data = sin.(2π .* (0:99) ./ 100) .* 5.0  # Sine wave
write(task, data)
wait_until_done(task)
```
"""
function Base.write(task::AOTask, data::AbstractVector{Float64};
                    auto_start::Bool=true,
                    timeout::Float64=10.0,
                    data_layout::FillMode=GroupByChannel)
    samples_written = Ref{Int32}(0)

    @check DAQmxWriteAnalogF64(
        task.handle,
        Int32(length(data)),
        Bool32(auto_start),
        timeout,
        Bool32(data_layout),
        pointer(data),
        Base.unsafe_convert(Ptr{Int32}, samples_written),
        Ptr{Bool32}()
    )

    return Int(samples_written[])
end

function Base.write(task::AOTask, data::AbstractMatrix{Float64};
                    auto_start::Bool=true,
                    timeout::Float64=10.0,
                    data_layout::FillMode=GroupByChannel)
    samples_per_chan = size(data, 1)
    flat_data = vec(data)
    samples_written = Ref{Int32}(0)

    @check DAQmxWriteAnalogF64(
        task.handle,
        Int32(samples_per_chan),
        Bool32(auto_start),
        timeout,
        Bool32(data_layout),
        pointer(flat_data),
        Base.unsafe_convert(Ptr{Int32}, samples_written),
        Ptr{Bool32}()
    )

    return Int(samples_written[])
end

"""
    write_scalar(task::AOTask, value::Float64; auto_start::Bool=true, timeout::Float64=10.0)

Write a single voltage value to an analog output task.
"""
function write_scalar(task::AOTask, value::Float64;
                      auto_start::Bool=true,
                      timeout::Float64=10.0)
    @check DAQmxWriteAnalogScalarF64(task.handle, Bool32(auto_start), timeout, value, Ptr{Bool32}())
    return nothing
end

# ============================================================================
# Digital Output Write
# ============================================================================

"""
    write(task::DOTask, data::AbstractArray{T}; kwargs...) where T

Write digital data to a digital output task.
Supported types: `UInt8`, `UInt16`, `UInt32`.
"""
function Base.write(task::DOTask, data::AbstractVector{UInt8};
                    auto_start::Bool=true,
                    timeout::Float64=10.0,
                    data_layout::FillMode=GroupByChannel)
    samples_written = Ref{Int32}(0)

    @check DAQmxWriteDigitalU8(
        task.handle,
        Int32(length(data)),
        Bool32(auto_start),
        timeout,
        Bool32(data_layout),
        pointer(data),
        Base.unsafe_convert(Ptr{Int32}, samples_written),
        Ptr{Bool32}()
    )

    return Int(samples_written[])
end

function Base.write(task::DOTask, data::AbstractMatrix{UInt8};
                    auto_start::Bool=true,
                    timeout::Float64=10.0,
                    data_layout::FillMode=GroupByChannel)
    samples_per_chan = size(data, 1)
    flat_data = vec(data)
    samples_written = Ref{Int32}(0)

    @check DAQmxWriteDigitalU8(
        task.handle,
        Int32(samples_per_chan),
        Bool32(auto_start),
        timeout,
        Bool32(data_layout),
        pointer(flat_data),
        Base.unsafe_convert(Ptr{Int32}, samples_written),
        Ptr{Bool32}()
    )

    return Int(samples_written[])
end

function Base.write(task::DOTask, data::AbstractVector{UInt16};
                    auto_start::Bool=true,
                    timeout::Float64=10.0,
                    data_layout::FillMode=GroupByChannel)
    samples_written = Ref{Int32}(0)

    @check DAQmxWriteDigitalU16(
        task.handle,
        Int32(length(data)),
        Bool32(auto_start),
        timeout,
        Bool32(data_layout),
        pointer(data),
        Base.unsafe_convert(Ptr{Int32}, samples_written),
        Ptr{Bool32}()
    )

    return Int(samples_written[])
end

function Base.write(task::DOTask, data::AbstractVector{UInt32};
                    auto_start::Bool=true,
                    timeout::Float64=10.0,
                    data_layout::FillMode=GroupByChannel)
    samples_written = Ref{Int32}(0)

    @check DAQmxWriteDigitalU32(
        task.handle,
        Int32(length(data)),
        Bool32(auto_start),
        timeout,
        Bool32(data_layout),
        pointer(data),
        Base.unsafe_convert(Ptr{Int32}, samples_written),
        Ptr{Bool32}()
    )

    return Int(samples_written[])
end

"""
    write_scalar(task::DOTask, value::UInt32; auto_start::Bool=true, timeout::Float64=10.0)

Write a single digital value to a digital output task.
"""
function write_scalar(task::DOTask, value::UInt32;
                      auto_start::Bool=true,
                      timeout::Float64=10.0)
    @check DAQmxWriteDigitalScalarU32(task.handle, Bool32(auto_start), timeout, value, Ptr{Bool32}())
    return nothing
end

# ============================================================================
# Buffer Management
# ============================================================================

"""
    available_samples(task::Task) -> Int

Get the number of samples available to read.
"""
function available_samples(task::Task)
    count = Ref{UInt32}(0)
    @check DAQmxGetReadAvailSampPerChan(task.handle, Base.unsafe_convert(Ptr{UInt32}, count))
    return Int(count[])
end

"""
    space_available(task::Task) -> Int

Get the amount of space available in the output buffer.
"""
function space_available(task::Task)
    count = Ref{UInt32}(0)
    @check DAQmxGetWriteSpaceAvail(task.handle, Base.unsafe_convert(Ptr{UInt32}, count))
    return Int(count[])
end

"""
    total_samples_acquired(task::Task) -> Int

Get the total number of samples acquired per channel.
"""
function total_samples_acquired(task::Task)
    count = Ref{UInt64}(0)
    @check DAQmxGetReadTotalSampPerChanAcquired(task.handle, Base.unsafe_convert(Ptr{UInt64}, count))
    return Int(count[])
end

"""
    total_samples_generated(task::Task) -> Int

Get the total number of samples generated per channel.
"""
function total_samples_generated(task::Task)
    count = Ref{UInt64}(0)
    @check DAQmxGetWriteTotalSampPerChanGenerated(task.handle, Base.unsafe_convert(Ptr{UInt64}, count))
    return Int(count[])
end
