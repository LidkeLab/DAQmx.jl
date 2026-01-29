# Type definitions for NIDAQmx.jl

# ============================================================================
# Task Types - Using parametric types instead of @eval loops
# ============================================================================

"""
    TaskKind

Abstract supertype for task kind type parameters.
"""
abstract type TaskKind end

struct AnalogInputKind <: TaskKind end
struct AnalogOutputKind <: TaskKind end
struct DigitalInputKind <: TaskKind end
struct DigitalOutputKind <: TaskKind end
struct CounterInputKind <: TaskKind end
struct CounterOutputKind <: TaskKind end

"""
    Task{K<:TaskKind}

A NIDAQmx task with parametric type for the task kind.
This allows for type-safe dispatch on different task types.

# Fields
- `handle::TaskHandle`: The underlying NIDAQmx task handle.
- `name::String`: The name of the task.

# Type Aliases
- `AITask = Task{AnalogInputKind}`
- `AOTask = Task{AnalogOutputKind}`
- `DITask = Task{DigitalInputKind}`
- `DOTask = Task{DigitalOutputKind}`
- `CITask = Task{CounterInputKind}`
- `COTask = Task{CounterOutputKind}`
"""
mutable struct Task{K<:TaskKind}
    handle::TaskHandle
    name::String

    function Task{K}(handle::TaskHandle, name::String="") where K<:TaskKind
        task = new{K}(handle, name)
        # Register finalizer to clean up the task handle
        finalizer(task) do t
            if t.handle != C_NULL
                DAQmxClearTask(t.handle)
                t.handle = C_NULL
            end
        end
        return task
    end
end

# Type aliases for common task types
const AITask = Task{AnalogInputKind}
const AOTask = Task{AnalogOutputKind}
const DITask = Task{DigitalInputKind}
const DOTask = Task{DigitalOutputKind}
const CITask = Task{CounterInputKind}
const COTask = Task{CounterOutputKind}

function Base.show(io::IO, task::Task{K}) where K
    kind_name = if K === AnalogInputKind
        "AnalogInput"
    elseif K === AnalogOutputKind
        "AnalogOutput"
    elseif K === DigitalInputKind
        "DigitalInput"
    elseif K === DigitalOutputKind
        "DigitalOutput"
    elseif K === CounterInputKind
        "CounterInput"
    elseif K === CounterOutputKind
        "CounterOutput"
    else
        string(K)
    end

    name_part = isempty(task.name) ? "" : " \"$(task.name)\""
    print(io, "Task{$kind_name}$name_part")
end

"""
    create_task(name::String="") -> TaskHandle

Create a new NIDAQmx task and return its handle.
"""
function create_task(name::String="")
    handle_ref = Ref{TaskHandle}(C_NULL)
    @check DAQmxCreateTask(Ptr{Cchar}(pointer(name)), Base.unsafe_convert(Ptr{TaskHandle}, handle_ref))
    return handle_ref[]
end

# Convenience constructors for specific task types (empty task, no channels)
AITask() = AITask(create_task(""), "")
AOTask() = AOTask(create_task(""), "")
DITask() = DITask(create_task(""), "")
DOTask() = DOTask(create_task(""), "")
CITask() = CITask(create_task(""), "")
COTask() = COTask(create_task(""), "")

# ============================================================================
# Channel Types
# ============================================================================

"""
    AbstractChannel

Abstract supertype for all channel types.
"""
abstract type AbstractChannel end

"""
    AnalogChannel <: AbstractChannel

Represents an analog channel (input or output).

# Fields
- `physical_channel::String`: The physical channel name (e.g., "Dev1/ai0").
- `name::String`: The assigned name for the channel.
"""
struct AnalogChannel <: AbstractChannel
    physical_channel::String
    name::String
end

AnalogChannel(physical_channel::String) = AnalogChannel(physical_channel, "")

"""
    DigitalChannel <: AbstractChannel

Represents a digital channel (input or output).

# Fields
- `lines::String`: The digital lines (e.g., "Dev1/port0/line0:7").
- `name::String`: The assigned name for the channel.
"""
struct DigitalChannel <: AbstractChannel
    lines::String
    name::String
end

DigitalChannel(lines::String) = DigitalChannel(lines, "")

"""
    CounterChannel <: AbstractChannel

Represents a counter channel (input or output).

# Fields
- `counter::String`: The counter name (e.g., "Dev1/ctr0").
- `name::String`: The assigned name for the channel.
"""
struct CounterChannel <: AbstractChannel
    counter::String
    name::String
end

CounterChannel(counter::String) = CounterChannel(counter, "")

# ============================================================================
# Enumerations - Using Julia enums instead of magic constants
# ============================================================================

"""
    TerminalConfig

Terminal configuration for analog input channels.
"""
@enum TerminalConfig::Int32 begin
    TerminalDefault = DAQmx_Val_Cfg_Default
    RSE = DAQmx_Val_RSE
    NRSE = DAQmx_Val_NRSE
    Differential = DAQmx_Val_Diff
    PseudoDifferential = DAQmx_Val_PseudoDiff
end

"""
    Edge

Edge type for triggers and timing.
"""
@enum Edge::Int32 begin
    Rising = DAQmx_Val_Rising
    Falling = DAQmx_Val_Falling
end

"""
    SampleMode

Sample acquisition mode.
"""
@enum SampleMode::Int32 begin
    FiniteSamples = DAQmx_Val_FiniteSamps
    ContinuousSamples = DAQmx_Val_ContSamps
    HardwareTimedSinglePoint = DAQmx_Val_HWTimedSinglePoint
end

"""
    SampleTimingType

Timing type for sample clock.
"""
@enum SampleTimingType::Int32 begin
    SampleClock = DAQmx_Val_SampClk
    BurstHandshake = DAQmx_Val_BurstHandshake
    Handshake = DAQmx_Val_Handshake
    Implicit = DAQmx_Val_Implicit
    OnDemand = DAQmx_Val_OnDemand
    ChangeDetection = DAQmx_Val_ChangeDetection
    PipelinedSampleClock = DAQmx_Val_PipelinedSampClk
end

"""
    FillMode

Data layout for read/write operations.
"""
@enum FillMode::Int32 begin
    GroupByChannel = DAQmx_Val_GroupByChannel
    GroupByScanNumber = DAQmx_Val_GroupByScanNumber
end

"""
    LineGrouping

Digital line grouping mode.
"""
@enum LineGrouping::Int32 begin
    ChannelPerLine = DAQmx_Val_ChanPerLine
    ChannelForAllLines = DAQmx_Val_ChanForAllLines
end

"""
    CountDirection

Direction for counter channels.
"""
@enum CountDirection::Int32 begin
    CountUp = DAQmx_Val_CountUp
    CountDown = DAQmx_Val_CountDown
    ExternallyControlled = DAQmx_Val_ExtControlled
end

"""
    Level

Logic level.
"""
@enum Level::Int32 begin
    Low = DAQmx_Val_Low
    High = DAQmx_Val_High
end

"""
    Coupling

Input coupling mode.
"""
@enum Coupling::Int32 begin
    CouplingAC = DAQmx_Val_AC
    CouplingDC = DAQmx_Val_DC
    CouplingGND = DAQmx_Val_GND
end

"""
    EncoderType

Encoder decoding type for angular/linear encoders.
"""
@enum EncoderType::Int32 begin
    EncoderX1 = DAQmx_Val_X1
    EncoderX2 = DAQmx_Val_X2
    EncoderX4 = DAQmx_Val_X4
    TwoPulseCounting = DAQmx_Val_TwoPulseCounting
end

"""
    ZIndexPhase

Z-index phase for encoders.
"""
@enum ZIndexPhase::Int32 begin
    AHighBHigh = DAQmx_Val_AHighBHigh
    AHighBLow = DAQmx_Val_AHighBLow
    ALowBHigh = DAQmx_Val_ALowBHigh
    ALowBLow = DAQmx_Val_ALowBLow
end

"""
    ExcitationSource

Excitation source for sensors.
"""
@enum ExcitationSource::Int32 begin
    ExcitationInternal = DAQmx_Val_Internal
    ExcitationExternal = DAQmx_Val_External
    ExcitationDefault = -1
end

"""
    ResistanceConfig

Resistance measurement configuration.
"""
@enum ResistanceConfig::Int32 begin
    TwoWire = DAQmx_Val_2Wire
    ThreeWire = DAQmx_Val_3Wire
    FourWire = DAQmx_Val_4Wire
end

"""
    TriggerType

Trigger type enumeration.
"""
@enum TriggerType::Int32 begin
    TriggerNone = DAQmx_Val_None
    TriggerDigitalEdge = DAQmx_Val_DigEdge
    TriggerDigitalPattern = DAQmx_Val_DigPattern
    TriggerAnalogEdge = DAQmx_Val_AnlgEdge
    TriggerAnalogWindow = DAQmx_Val_AnlgWin
end

"""
    Slope

Slope for analog triggers.
"""
@enum Slope::Int32 begin
    RisingSlope = DAQmx_Val_RisingSlope
    FallingSlope = DAQmx_Val_FallingSlope
end

# ============================================================================
# Utility Functions
# ============================================================================

"""
    task_handle(task::Task) -> TaskHandle

Get the underlying NIDAQmx handle for a task.
"""
task_handle(task::Task) = task.handle

"""
    is_valid(task::Task) -> Bool

Check if a task has a valid (non-null) handle.
"""
is_valid(task::Task) = task.handle != C_NULL

"""
    task_kind(::Task{K}) where K

Get the task kind type parameter.
"""
task_kind(::Task{K}) where K = K
