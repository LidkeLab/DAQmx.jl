# Timing configuration for NIDAQmx.jl

"""
    configure_timing!(task::Task;
                      source::String="",
                      rate::Float64=1000.0,
                      active_edge::Edge=Rising,
                      sample_mode::SampleMode=FiniteSamples,
                      samples_per_channel::Int=1000)

Configure sample clock timing for a task.

# Arguments
- `task::Task`: The task to configure.

# Keyword Arguments
- `source::String`: Source terminal for the sample clock (default: "" for internal clock).
- `rate::Float64`: Sample rate in samples per second (default: 1000.0).
- `active_edge::Edge`: Edge to use for sampling (`Rising` or `Falling`).
- `sample_mode::SampleMode`: Sampling mode:
  - `FiniteSamples`: Acquire a finite number of samples.
  - `ContinuousSamples`: Acquire continuously until stopped.
  - `HardwareTimedSinglePoint`: Hardware-timed single point.
- `samples_per_channel::Int`: Number of samples per channel to acquire/generate.

# Example
```julia
task = AITask("Dev1/ai0")
configure_timing!(task; rate=10000.0, samples_per_channel=1000, sample_mode=FiniteSamples)
```
"""
function configure_timing!(task::Task;
                           source::String="",
                           rate::Float64=1000.0,
                           active_edge::Edge=Rising,
                           sample_mode::SampleMode=FiniteSamples,
                           samples_per_channel::Int=1000)

    @check DAQmxCfgSampClkTiming(
        task.handle,
        isempty(source) ? NULLSTR : _cstr(source),
        rate,
        Int32(active_edge),
        Int32(sample_mode),
        UInt64(samples_per_channel)
    )

    return task
end

"""
    configure_implicit_timing!(task::Task;
                               sample_mode::SampleMode=FiniteSamples,
                               samples_per_channel::Int=1000)

Configure implicit timing for tasks that don't use a sample clock.
This is typically used for counter output tasks.

# Example
```julia
task = COTask("Dev1/ctr0"; freq=1000.0, duty_cycle=0.5)
configure_implicit_timing!(task; sample_mode=ContinuousSamples, samples_per_channel=1000)
start!(task)
```
"""
function configure_implicit_timing!(task::Task;
                                    sample_mode::SampleMode=FiniteSamples,
                                    samples_per_channel::Int=1000)

    @check DAQmxCfgImplicitTiming(
        task.handle,
        Int32(sample_mode),
        UInt64(samples_per_channel)
    )

    return task
end

"""
    configure_change_detection_timing!(task::DITask;
                                       rising_edge_channels::String="",
                                       falling_edge_channels::String="",
                                       sample_mode::SampleMode=FiniteSamples,
                                       samples_per_channel::Int=1000)

Configure change detection timing for digital input tasks.
The task will generate a sample when a change is detected on the specified channels.

# Keyword Arguments
- `rising_edge_channels::String`: Channels to detect rising edges on.
- `falling_edge_channels::String`: Channels to detect falling edges on.
"""
function configure_change_detection_timing!(task::DITask;
                                            rising_edge_channels::String="",
                                            falling_edge_channels::String="",
                                            sample_mode::SampleMode=FiniteSamples,
                                            samples_per_channel::Int=1000)

    @check DAQmxCfgChangeDetectionTiming(
        task.handle,
        isempty(rising_edge_channels) ? NULLSTR : _cstr(rising_edge_channels),
        isempty(falling_edge_channels) ? NULLSTR : _cstr(falling_edge_channels),
        Int32(sample_mode),
        UInt64(samples_per_channel)
    )

    return task
end

"""
    configure_handshaking_timing!(task::Task;
                                  sample_mode::SampleMode=FiniteSamples,
                                  samples_per_channel::Int=1000)

Configure handshaking timing for a task.
"""
function configure_handshaking_timing!(task::Task;
                                       sample_mode::SampleMode=FiniteSamples,
                                       samples_per_channel::Int=1000)

    @check DAQmxCfgHandshakingTiming(
        task.handle,
        Int32(sample_mode),
        UInt64(samples_per_channel)
    )

    return task
end

# ============================================================================
# Trigger Configuration
# ============================================================================

"""
    configure_digital_start_trigger!(task::Task, source::String;
                                     edge::Edge=Rising)

Configure a digital edge start trigger for the task.

# Arguments
- `task::Task`: The task to configure.
- `source::String`: Trigger source terminal (e.g., "/Dev1/PFI0").
- `edge::Edge`: Edge to trigger on (`Rising` or `Falling`).

# Example
```julia
task = AITask("Dev1/ai0")
configure_timing!(task; rate=10000.0, samples_per_channel=1000)
configure_digital_start_trigger!(task, "/Dev1/PFI0"; edge=Rising)
start!(task)  # Task will wait for trigger
```
"""
function configure_digital_start_trigger!(task::Task, source::String;
                                          edge::Edge=Rising)

    @check DAQmxCfgDigEdgeStartTrig(
        task.handle,
        pointer(source),
        Int32(edge)
    )

    return task
end

"""
    configure_analog_start_trigger!(task::Task, source::String;
                                    slope::Slope=RisingSlope,
                                    level::Float64=0.0)

Configure an analog edge start trigger for the task.

# Arguments
- `task::Task`: The task to configure.
- `source::String`: Trigger source channel (e.g., "Dev1/ai0").
- `slope::Slope`: Trigger slope (`RisingSlope` or `FallingSlope`).
- `level::Float64`: Trigger level in volts.
"""
function configure_analog_start_trigger!(task::Task, source::String;
                                         slope::Slope=RisingSlope,
                                         level::Float64=0.0)

    @check DAQmxCfgAnlgEdgeStartTrig(
        task.handle,
        pointer(source),
        Int32(slope),
        level
    )

    return task
end

"""
    configure_analog_window_start_trigger!(task::Task, source::String;
                                           when::Symbol=:EnteringWindow,
                                           window_top::Float64=1.0,
                                           window_bottom::Float64=-1.0)

Configure an analog window start trigger for the task.

# Keyword Arguments
- `when::Symbol`: When to trigger (`:EnteringWindow` or `:LeavingWindow`).
- `window_top::Float64`: Top of the trigger window.
- `window_bottom::Float64`: Bottom of the trigger window.
"""
function configure_analog_window_start_trigger!(task::Task, source::String;
                                                when::Symbol=:EnteringWindow,
                                                window_top::Float64=1.0,
                                                window_bottom::Float64=-1.0)

    when_code = if when === :EnteringWindow
        10163  # DAQmx_Val_EnteringWin
    elseif when === :LeavingWindow
        10208  # DAQmx_Val_LeavingWin
    else
        throw(ArgumentError("Unknown when: $when"))
    end

    @check DAQmxCfgAnlgWindowStartTrig(
        task.handle,
        pointer(source),
        when_code,
        window_top,
        window_bottom
    )

    return task
end

"""
    disable_start_trigger!(task::Task)

Disable the start trigger for a task.
"""
function disable_start_trigger!(task::Task)
    @check DAQmxDisableStartTrig(task.handle)
    return task
end

"""
    configure_digital_ref_trigger!(task::Task, source::String;
                                   edge::Edge=Rising,
                                   pretrigger_samples::Int=100)

Configure a digital edge reference trigger.

# Arguments
- `source::String`: Trigger source terminal.
- `edge::Edge`: Edge to trigger on.
- `pretrigger_samples::Int`: Number of samples to acquire before the trigger.
"""
function configure_digital_ref_trigger!(task::Task, source::String;
                                        edge::Edge=Rising,
                                        pretrigger_samples::Int=100)

    @check DAQmxCfgDigEdgeRefTrig(
        task.handle,
        pointer(source),
        Int32(edge),
        UInt32(pretrigger_samples)
    )

    return task
end

"""
    configure_analog_ref_trigger!(task::Task, source::String;
                                  slope::Slope=RisingSlope,
                                  level::Float64=0.0,
                                  pretrigger_samples::Int=100)

Configure an analog edge reference trigger.
"""
function configure_analog_ref_trigger!(task::Task, source::String;
                                       slope::Slope=RisingSlope,
                                       level::Float64=0.0,
                                       pretrigger_samples::Int=100)

    @check DAQmxCfgAnlgEdgeRefTrig(
        task.handle,
        pointer(source),
        Int32(slope),
        level,
        UInt32(pretrigger_samples)
    )

    return task
end

"""
    disable_ref_trigger!(task::Task)

Disable the reference trigger for a task.
"""
function disable_ref_trigger!(task::Task)
    @check DAQmxDisableRefTrig(task.handle)
    return task
end

# ============================================================================
# Timing Properties
# ============================================================================

"""
    sample_rate(task::Task) -> Float64

Get the sample clock rate for a task.
"""
function sample_rate(task::Task)
    rate = Ref{Float64}(0.0)
    @check DAQmxGetSampClkRate(task.handle, rate)
    return rate[]
end

"""
    set_sample_rate!(task::Task, rate::Float64)

Set the sample clock rate for a task.
"""
function set_sample_rate!(task::Task, rate::Float64)
    @check DAQmxSetSampClkRate(task.handle, rate)
    return task
end

"""
    sample_clock_source(task::Task) -> String

Get the sample clock source terminal.
"""
function sample_clock_source(task::Task)
    sz = DAQmxGetSampClkSrc(task.handle, NULLSTR, UInt32(0))
    sz <= 0 && return ""

    buffer = Vector{Int8}(undef, sz)
    @check DAQmxGetSampClkSrc(task.handle, pointer(buffer), UInt32(sz))
    return unsafe_string(Ptr{UInt8}(pointer(buffer)))
end

"""
    set_sample_clock_source!(task::Task, source::String)

Set the sample clock source terminal.
"""
function set_sample_clock_source!(task::Task, source::String)
    @check DAQmxSetSampClkSrc(task.handle, pointer(source))
    return task
end

"""
    samples_per_channel(task::Task) -> Int

Get the number of samples per channel for the task.
"""
function samples_per_channel(task::Task)
    count = Ref{UInt64}(0)
    @check DAQmxGetSampQuantSampPerChan(task.handle, count)
    return Int(count[])
end

"""
    set_samples_per_channel!(task::Task, count::Int)

Set the number of samples per channel for the task.
"""
function set_samples_per_channel!(task::Task, count::Int)
    @check DAQmxSetSampQuantSampPerChan(task.handle, UInt64(count))
    return task
end

# ============================================================================
# Buffer Configuration
# ============================================================================

"""
    configure_input_buffer!(task::Task, samples_per_channel::Int)

Configure the size of the input buffer.
"""
function configure_input_buffer!(task::Task, samples_per_channel::Int)
    @check DAQmxCfgInputBuffer(task.handle, UInt32(samples_per_channel))
    return task
end

"""
    configure_output_buffer!(task::Task, samples_per_channel::Int)

Configure the size of the output buffer.
"""
function configure_output_buffer!(task::Task, samples_per_channel::Int)
    @check DAQmxCfgOutputBuffer(task.handle, UInt32(samples_per_channel))
    return task
end

"""
    input_buffer_size(task::Task) -> Int

Get the input buffer size per channel.
"""
function input_buffer_size(task::Task)
    size = Ref{UInt32}(0)
    @check DAQmxGetBufInputBufSize(task.handle, size)
    return Int(size[])
end

"""
    set_input_buffer_size!(task::Task, size::Int)

Set the input buffer size per channel.
"""
function set_input_buffer_size!(task::Task, size::Int)
    @check DAQmxSetBufInputBufSize(task.handle, UInt32(size))
    return task
end

"""
    output_buffer_size(task::Task) -> Int

Get the output buffer size per channel.
"""
function output_buffer_size(task::Task)
    size = Ref{UInt32}(0)
    @check DAQmxGetBufOutputBufSize(task.handle, size)
    return Int(size[])
end

"""
    set_output_buffer_size!(task::Task, size::Int)

Set the output buffer size per channel.
"""
function set_output_buffer_size!(task::Task, size::Int)
    @check DAQmxSetBufOutputBufSize(task.handle, UInt32(size))
    return task
end
