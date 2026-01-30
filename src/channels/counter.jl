# Counter channel functions for DAQmx.jl

"""
    add_ci_count_edges!(task::CITask, counter::String;
                        edge::Edge=Rising,
                        initial_count::UInt32=UInt32(0),
                        count_direction::CountDirection=CountUp,
                        name::String="")

Add a counter input channel that counts edges.

# Arguments
- `task::CITask`: The counter input task.
- `counter::String`: Counter name (e.g., "Dev1/ctr0").

# Keyword Arguments
- `edge::Edge`: Which edge to count (default: `Rising`).
- `initial_count::UInt32`: Starting count value (default: 0).
- `count_direction::CountDirection`: Count direction (default: `CountUp`).
- `name::String`: Name to assign to the channel.

# Example
```julia
task = CITask()
add_ci_count_edges!(task, "Dev1/ctr0"; edge=Rising, count_direction=CountUp)
configure_timing!(task; sample_mode=ContinuousSamples)
start!(task)
counts = read(task; samples_per_channel=100)
```
"""
function add_ci_count_edges!(task::CITask, counter::String;
                             edge::Edge=Rising,
                             initial_count::UInt32=UInt32(0),
                             count_direction::CountDirection=CountUp,
                             name::String="")

    @check DAQmxCreateCICountEdgesChan(
        task.handle,
        _cstr(counter),
        _cstr(name),
        Int32(edge),
        initial_count,
        Int32(count_direction)
    )

    return task
end

"""
    add_ci_freq!(task::CITask, counter::String;
                 min_val::Float64=1.0,
                 max_val::Float64=1000000.0,
                 units::Symbol=:Hz,
                 edge::Edge=Rising,
                 meas_method::Symbol=:LowFreq1Ctr,
                 meas_time::Float64=0.001,
                 divisor::UInt32=UInt32(4),
                 name::String="",
                 custom_scale::String="")

Add a counter input channel that measures frequency.

# Keyword Arguments
- `meas_method::Symbol`: Measurement method (`:LowFreq1Ctr`, `:HighFreq2Ctr`, `:LargeRng2Ctr`).
- `meas_time::Float64`: Measurement time for low frequency method (seconds).
- `divisor::UInt32`: Divisor for high frequency method.
"""
function add_ci_freq!(task::CITask, counter::String;
                      min_val::Float64=1.0,
                      max_val::Float64=1000000.0,
                      units::Symbol=:Hz,
                      edge::Edge=Rising,
                      meas_method::Symbol=:LowFreq1Ctr,
                      meas_time::Float64=0.001,
                      divisor::UInt32=UInt32(4),
                      name::String="",
                      custom_scale::String="")

    units_code = if units === :Hz
        DAQmx_Val_Hz
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    meas_method_code = if meas_method === :LowFreq1Ctr
        DAQmx_Val_LowFreq1Ctr
    elseif meas_method === :HighFreq2Ctr
        DAQmx_Val_HighFreq2Ctr
    elseif meas_method === :LargeRng2Ctr
        DAQmx_Val_LargeRng2Ctr
    else
        throw(ArgumentError("Unknown meas_method: $meas_method"))
    end

    @check DAQmxCreateCIFreqChan(
        task.handle,
        _cstr(counter),
        _cstr(name),
        min_val,
        max_val,
        units_code,
        Int32(edge),
        meas_method_code,
        meas_time,
        divisor,
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ci_period!(task::CITask, counter::String;
                   min_val::Float64=0.000001,
                   max_val::Float64=1.0,
                   units::Symbol=:Seconds,
                   edge::Edge=Rising,
                   meas_method::Symbol=:LowFreq1Ctr,
                   meas_time::Float64=0.001,
                   divisor::UInt32=UInt32(4),
                   name::String="",
                   custom_scale::String="")

Add a counter input channel that measures period.
"""
function add_ci_period!(task::CITask, counter::String;
                        min_val::Float64=0.000001,
                        max_val::Float64=1.0,
                        units::Symbol=:Seconds,
                        edge::Edge=Rising,
                        meas_method::Symbol=:LowFreq1Ctr,
                        meas_time::Float64=0.001,
                        divisor::UInt32=UInt32(4),
                        name::String="",
                        custom_scale::String="")

    units_code = if units === :Seconds
        DAQmx_Val_Seconds
    elseif units === :Ticks
        DAQmx_Val_Ticks
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    meas_method_code = if meas_method === :LowFreq1Ctr
        DAQmx_Val_LowFreq1Ctr
    elseif meas_method === :HighFreq2Ctr
        DAQmx_Val_HighFreq2Ctr
    elseif meas_method === :LargeRng2Ctr
        DAQmx_Val_LargeRng2Ctr
    else
        throw(ArgumentError("Unknown meas_method: $meas_method"))
    end

    @check DAQmxCreateCIPeriodChan(
        task.handle,
        _cstr(counter),
        _cstr(name),
        min_val,
        max_val,
        units_code,
        Int32(edge),
        meas_method_code,
        meas_time,
        divisor,
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ci_pulse_width!(task::CITask, counter::String;
                        min_val::Float64=0.000001,
                        max_val::Float64=1.0,
                        units::Symbol=:Seconds,
                        starting_edge::Edge=Rising,
                        name::String="",
                        custom_scale::String="")

Add a counter input channel that measures pulse width.
"""
function add_ci_pulse_width!(task::CITask, counter::String;
                             min_val::Float64=0.000001,
                             max_val::Float64=1.0,
                             units::Symbol=:Seconds,
                             starting_edge::Edge=Rising,
                             name::String="",
                             custom_scale::String="")

    units_code = if units === :Seconds
        DAQmx_Val_Seconds
    elseif units === :Ticks
        DAQmx_Val_Ticks
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    @check DAQmxCreateCIPulseWidthChan(
        task.handle,
        _cstr(counter),
        _cstr(name),
        min_val,
        max_val,
        units_code,
        Int32(starting_edge),
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ci_two_edge_sep!(task::CITask, counter::String;
                         min_val::Float64=0.000001,
                         max_val::Float64=1.0,
                         units::Symbol=:Seconds,
                         first_edge::Edge=Rising,
                         second_edge::Edge=Falling,
                         name::String="",
                         custom_scale::String="")

Add a counter input channel that measures time between two edges.
"""
function add_ci_two_edge_sep!(task::CITask, counter::String;
                              min_val::Float64=0.000001,
                              max_val::Float64=1.0,
                              units::Symbol=:Seconds,
                              first_edge::Edge=Rising,
                              second_edge::Edge=Falling,
                              name::String="",
                              custom_scale::String="")

    units_code = if units === :Seconds
        DAQmx_Val_Seconds
    elseif units === :Ticks
        DAQmx_Val_Ticks
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    @check DAQmxCreateCITwoEdgeSepChan(
        task.handle,
        _cstr(counter),
        _cstr(name),
        min_val,
        max_val,
        units_code,
        Int32(first_edge),
        Int32(second_edge),
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ci_ang_encoder!(task::CITask, counter::String;
                        decoding_type::EncoderType=EncoderX4,
                        z_idx_enable::Bool=true,
                        z_idx_val::Float64=0.0,
                        z_idx_phase::ZIndexPhase=AHighBHigh,
                        units::Symbol=:Degrees,
                        pulses_per_rev::UInt32=UInt32(1024),
                        initial_angle::Float64=0.0,
                        name::String="",
                        custom_scale::String="")

Add an angular encoder input channel.

# Keyword Arguments
- `decoding_type::EncoderType`: Encoder decoding (`:EncoderX1`, `:EncoderX2`, `:EncoderX4`, `:TwoPulseCounting`).
- `z_idx_enable::Bool`: Enable Z-index.
- `z_idx_val::Float64`: Z-index value.
- `z_idx_phase::ZIndexPhase`: Z-index phase.
- `pulses_per_rev::UInt32`: Pulses per revolution.
- `initial_angle::Float64`: Initial angle value.
"""
function add_ci_ang_encoder!(task::CITask, counter::String;
                             decoding_type::EncoderType=EncoderX4,
                             z_idx_enable::Bool=true,
                             z_idx_val::Float64=0.0,
                             z_idx_phase::ZIndexPhase=AHighBHigh,
                             units::Symbol=:Degrees,
                             pulses_per_rev::UInt32=UInt32(1024),
                             initial_angle::Float64=0.0,
                             name::String="",
                             custom_scale::String="")

    units_code = if units === :Degrees
        DAQmx_Val_Degrees
    elseif units === :Radians
        DAQmx_Val_Radians
    elseif units === :Ticks
        DAQmx_Val_Ticks
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    @check DAQmxCreateCIAngEncoderChan(
        task.handle,
        _cstr(counter),
        _cstr(name),
        Int32(decoding_type),
        Bool32(z_idx_enable),
        z_idx_val,
        Int32(z_idx_phase),
        units_code,
        pulses_per_rev,
        initial_angle,
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ci_lin_encoder!(task::CITask, counter::String;
                        decoding_type::EncoderType=EncoderX4,
                        z_idx_enable::Bool=false,
                        z_idx_val::Float64=0.0,
                        z_idx_phase::ZIndexPhase=AHighBHigh,
                        units::Symbol=:Meters,
                        dist_per_pulse::Float64=0.001,
                        initial_pos::Float64=0.0,
                        name::String="",
                        custom_scale::String="")

Add a linear encoder input channel.
"""
function add_ci_lin_encoder!(task::CITask, counter::String;
                             decoding_type::EncoderType=EncoderX4,
                             z_idx_enable::Bool=false,
                             z_idx_val::Float64=0.0,
                             z_idx_phase::ZIndexPhase=AHighBHigh,
                             units::Symbol=:Meters,
                             dist_per_pulse::Float64=0.001,
                             initial_pos::Float64=0.0,
                             name::String="",
                             custom_scale::String="")

    units_code = if units === :Meters
        DAQmx_Val_Meters
    elseif units === :Inches
        DAQmx_Val_Inches
    elseif units === :Ticks
        DAQmx_Val_Ticks
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    @check DAQmxCreateCILinEncoderChan(
        task.handle,
        _cstr(counter),
        _cstr(name),
        Int32(decoding_type),
        Bool32(z_idx_enable),
        z_idx_val,
        Int32(z_idx_phase),
        units_code,
        dist_per_pulse,
        initial_pos,
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

# ============================================================================
# Counter Output Channels
# ============================================================================

"""
    add_co_pulse_freq!(task::COTask, counter::String;
                       units::Symbol=:Hz,
                       idle_state::Level=Low,
                       initial_delay::Float64=0.0,
                       freq::Float64=1000.0,
                       duty_cycle::Float64=0.5,
                       name::String="")

Add a counter output pulse channel using frequency and duty cycle.

# Arguments
- `task::COTask`: The counter output task.
- `counter::String`: Counter name (e.g., "Dev1/ctr0").

# Keyword Arguments
- `units::Symbol`: Frequency units (`:Hz`).
- `idle_state::Level`: Idle state (`Low` or `High`).
- `initial_delay::Float64`: Initial delay before first pulse (seconds).
- `freq::Float64`: Pulse frequency in Hz.
- `duty_cycle::Float64`: Duty cycle (0.0 to 1.0).

# Example
```julia
task = COTask()
add_co_pulse_freq!(task, "Dev1/ctr0"; freq=1000.0, duty_cycle=0.5)
configure_timing!(task; sample_mode=ContinuousSamples, samples_per_channel=1000)
start!(task)
```
"""
function add_co_pulse_freq!(task::COTask, counter::String;
                            units::Symbol=:Hz,
                            idle_state::Level=Low,
                            initial_delay::Float64=0.0,
                            freq::Float64=1000.0,
                            duty_cycle::Float64=0.5,
                            name::String="")

    units_code = if units === :Hz
        DAQmx_Val_Hz
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    @check DAQmxCreateCOPulseChanFreq(
        task.handle,
        _cstr(counter),
        _cstr(name),
        units_code,
        Int32(idle_state),
        initial_delay,
        freq,
        duty_cycle
    )

    return task
end

"""
    add_co_pulse_time!(task::COTask, counter::String;
                       units::Symbol=:Seconds,
                       idle_state::Level=Low,
                       initial_delay::Float64=0.0,
                       low_time::Float64=0.001,
                       high_time::Float64=0.001,
                       name::String="")

Add a counter output pulse channel using high/low times.

# Keyword Arguments
- `low_time::Float64`: Time the pulse is low (seconds).
- `high_time::Float64`: Time the pulse is high (seconds).
"""
function add_co_pulse_time!(task::COTask, counter::String;
                            units::Symbol=:Seconds,
                            idle_state::Level=Low,
                            initial_delay::Float64=0.0,
                            low_time::Float64=0.001,
                            high_time::Float64=0.001,
                            name::String="")

    units_code = if units === :Seconds
        DAQmx_Val_Seconds
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    @check DAQmxCreateCOPulseChanTime(
        task.handle,
        _cstr(counter),
        _cstr(name),
        units_code,
        Int32(idle_state),
        initial_delay,
        low_time,
        high_time
    )

    return task
end

"""
    add_co_pulse_ticks!(task::COTask, counter::String;
                        source_terminal::String="",
                        idle_state::Level=Low,
                        initial_delay::Int32=Int32(0),
                        low_ticks::Int32=Int32(100),
                        high_ticks::Int32=Int32(100),
                        name::String="")

Add a counter output pulse channel using tick counts.

# Keyword Arguments
- `source_terminal::String`: Source terminal for the timebase.
- `low_ticks::Int32`: Number of ticks the pulse is low.
- `high_ticks::Int32`: Number of ticks the pulse is high.
"""
function add_co_pulse_ticks!(task::COTask, counter::String;
                             source_terminal::String="",
                             idle_state::Level=Low,
                             initial_delay::Int32=Int32(0),
                             low_ticks::Int32=Int32(100),
                             high_ticks::Int32=Int32(100),
                             name::String="")

    @check DAQmxCreateCOPulseChanTicks(
        task.handle,
        _cstr(counter),
        _cstr(name),
        isempty(source_terminal) ? NULLSTR : _cstr(source_terminal),
        Int32(idle_state),
        initial_delay,
        low_ticks,
        high_ticks
    )

    return task
end

# ============================================================================
# Convenience Constructors
# ============================================================================

"""
    CITask(counter::String; method::Symbol=:count_edges, kwargs...) -> CITask

Create a counter input task.

# Arguments
- `counter::String`: Counter name.
- `method::Symbol`: Measurement method (`:count_edges`, `:freq`, `:period`, etc.).
"""
function CITask(counter::String; method::Symbol=:count_edges, kwargs...)
    task = CITask()
    if method === :count_edges
        add_ci_count_edges!(task, counter; kwargs...)
    elseif method === :freq
        add_ci_freq!(task, counter; kwargs...)
    elseif method === :period
        add_ci_period!(task, counter; kwargs...)
    elseif method === :pulse_width
        add_ci_pulse_width!(task, counter; kwargs...)
    elseif method === :two_edge_sep
        add_ci_two_edge_sep!(task, counter; kwargs...)
    elseif method === :ang_encoder
        add_ci_ang_encoder!(task, counter; kwargs...)
    elseif method === :lin_encoder
        add_ci_lin_encoder!(task, counter; kwargs...)
    else
        throw(ArgumentError("Unknown method: $method"))
    end
    return task
end

"""
    COTask(counter::String; method::Symbol=:pulse_freq, kwargs...) -> COTask

Create a counter output task.

# Arguments
- `counter::String`: Counter name.
- `method::Symbol`: Output method (`:pulse_freq`, `:pulse_time`, `:pulse_ticks`).
"""
function COTask(counter::String; method::Symbol=:pulse_freq, kwargs...)
    task = COTask()
    if method === :pulse_freq
        add_co_pulse_freq!(task, counter; kwargs...)
    elseif method === :pulse_time
        add_co_pulse_time!(task, counter; kwargs...)
    elseif method === :pulse_ticks
        add_co_pulse_ticks!(task, counter; kwargs...)
    else
        throw(ArgumentError("Unknown method: $method"))
    end
    return task
end
