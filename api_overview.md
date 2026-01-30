# NIDAQmx.jl API Reference

Julia wrapper for National Instruments NI-DAQmx driver, providing type-safe access to NI data acquisition hardware.

## Exports Summary

- **Types:** 37
- **Functions:** 96
- **Constants:** 40

## Key Concepts

NIDAQmx.jl uses parametric task types (`Task{K}`) where `K` indicates the task kind (analog input, digital output, etc.). This enables type-safe dispatch and compile-time guarantees about valid operations. Tasks automatically clean up handles via finalizers. Julia enums replace raw DAQmx constants for terminal configuration, edges, and sample modes.

## Types

### Task{K<:TaskKind}

```julia
Task{K<:TaskKind}
```

A NIDAQmx task parameterized by kind for type-safe dispatch.

**Fields:**
- `handle::TaskHandle`: The underlying NIDAQmx task handle
- `name::String`: The name of the task

**Type Aliases:**
- `AITask = Task{AnalogInputKind}` - Analog input task
- `AOTask = Task{AnalogOutputKind}` - Analog output task
- `DITask = Task{DigitalInputKind}` - Digital input task
- `DOTask = Task{DigitalOutputKind}` - Digital output task
- `CITask = Task{CounterInputKind}` - Counter input task
- `COTask = Task{CounterOutputKind}` - Counter output task

**Constructors:**
```julia
AITask()                              # Empty task
AITask("Dev1/ai0")                    # Task with voltage channel
AITask("Dev1/ai0"; terminal_config=RSE, min_val=-5.0, max_val=5.0)

AOTask()
AOTask("Dev1/ao0")
AOTask("Dev1/ao0"; min_val=0.0, max_val=5.0)

DITask()
DITask("Dev1/port0/line0:7")

DOTask()
DOTask("Dev1/port0/line0:7")

CITask()
CITask("Dev1/ctr0"; method=:count_edges)
CITask("Dev1/ctr0"; method=:freq)

COTask()
COTask("Dev1/ctr0"; method=:pulse_freq, freq=1000.0)
```

### Device

```julia
Device
```

Represents a NI-DAQmx device.

**Fields:**
- `name::String`: Device name (e.g., "Dev1")

### Channel Types

```julia
AbstractChannel           # Abstract supertype
AnalogChannel <: AbstractChannel
DigitalChannel <: AbstractChannel
CounterChannel <: AbstractChannel
```

**AnalogChannel Fields:**
- `physical_channel::String`: Physical channel name (e.g., "Dev1/ai0")
- `name::String`: Assigned channel name

**DigitalChannel Fields:**
- `lines::String`: Digital lines (e.g., "Dev1/port0/line0:7")
- `name::String`: Assigned channel name

**CounterChannel Fields:**
- `counter::String`: Counter name (e.g., "Dev1/ctr0")
- `name::String`: Assigned channel name

### Enumerations

```julia
TerminalConfig  # TerminalDefault, RSE, NRSE, Differential, PseudoDifferential
Edge            # Rising, Falling
SampleMode      # FiniteSamples, ContinuousSamples, HardwareTimedSinglePoint
FillMode        # GroupByChannel, GroupByScanNumber
LineGrouping    # ChannelPerLine, ChannelForAllLines
CountDirection  # CountUp, CountDown, ExternallyControlled
Level           # Low, High
Coupling        # CouplingAC, CouplingDC, CouplingGND
EncoderType     # EncoderX1, EncoderX2, EncoderX4, TwoPulseCounting
ZIndexPhase     # AHighBHigh, AHighBLow, ALowBHigh, ALowBLow
ExcitationSource # ExcitationInternal, ExcitationExternal, ExcitationDefault
ResistanceConfig # TwoWire, ThreeWire, FourWire
TriggerType     # TriggerNone, TriggerDigitalEdge, TriggerAnalogEdge, etc.
Slope           # RisingSlope, FallingSlope
```

### NIDAQError / NIDAQWarning

```julia
NIDAQError <: Exception
NIDAQWarning
```

Error and warning types for DAQmx operations.

## Functions

### Device Enumeration

```julia
devices() -> Vector{Device}
device_names() -> Vector{String}
```

List available NI-DAQmx devices.

### Device Properties

```julia
product_type(device) -> String          # e.g., "USB-6001"
product_number(device) -> UInt32
serial_number(device) -> UInt32
is_simulated(device) -> Bool
```

### Device Channels

```julia
ai_channels(device) -> Vector{String}   # ["Dev1/ai0", "Dev1/ai1", ...]
ao_channels(device) -> Vector{String}
di_lines(device) -> Vector{String}
do_lines(device) -> Vector{String}
di_ports(device) -> Vector{String}
do_ports(device) -> Vector{String}
ci_channels(device) -> Vector{String}
co_channels(device) -> Vector{String}
terminals(device) -> Vector{String}
```

### Device Ranges

```julia
ai_voltage_ranges(device) -> Matrix{Float64}  # N×2 matrix [min max]
ao_voltage_ranges(device) -> Matrix{Float64}
ai_current_ranges(device) -> Matrix{Float64}
ao_current_ranges(device) -> Matrix{Float64}
```

### Device Control

```julia
self_calibrate!(device)
reset!(device)
```

### Task Lifecycle

```julia
start!(task)                           # Start task operations
stop!(task)                            # Stop task
clear!(task)                           # Clear and release resources
wait_until_done(task; timeout=-1.0)    # Wait for completion
is_done(task) -> Bool                  # Check if done
control!(task, action::Symbol)         # :start, :stop, :verify, :commit, :reserve, :unreserve, :abort
```

### Task Information

```julia
num_channels(task) -> Int
task_name(task) -> String
channel_names(task) -> Vector{String}
device_names(task) -> Vector{String}
```

### Analog Input Channels

```julia
add_ai_voltage!(task, channel; terminal_config=Differential, min_val=-10.0, max_val=10.0, ...)
add_ai_current!(task, channel; terminal_config=Differential, min_val=-0.01, max_val=0.01, ...)
add_ai_thermocouple!(task, channel; thermocouple_type=:K_Type, units=:DegC, ...)
add_ai_rtd!(task, channel; rtd_type=:Pt3851, resistance_config=FourWire, ...)
add_ai_resistance!(task, channel; resistance_config=TwoWire, ...)
add_ai_accel!(task, channel; sensitivity=100.0, ...)
```

### Analog Output Channels

```julia
add_ao_voltage!(task, channel; min_val=-10.0, max_val=10.0, ...)
add_ao_current!(task, channel; min_val=0.0, max_val=0.02, ...)
add_ao_funcgen!(task, channel; type=:Sine, freq=1000.0, amplitude=1.0, offset=0.0)
```

### Digital Channels

```julia
add_di_chan!(task, lines; line_grouping=ChannelPerLine, ...)
add_do_chan!(task, lines; line_grouping=ChannelPerLine, ...)
```

### Counter Input Channels

```julia
add_ci_count_edges!(task, counter; edge=Rising, count_direction=CountUp, ...)
add_ci_freq!(task, counter; meas_method=:LowFreq1Ctr, ...)
add_ci_period!(task, counter; ...)
add_ci_pulse_width!(task, counter; ...)
add_ci_two_edge_sep!(task, counter; first_edge=Rising, second_edge=Falling, ...)
add_ci_ang_encoder!(task, counter; decoding_type=EncoderX4, pulses_per_rev=1024, ...)
add_ci_lin_encoder!(task, counter; dist_per_pulse=0.001, ...)
```

### Counter Output Channels

```julia
add_co_pulse_freq!(task, counter; freq=1000.0, duty_cycle=0.5, idle_state=Low, ...)
add_co_pulse_time!(task, counter; low_time=0.001, high_time=0.001, ...)
add_co_pulse_ticks!(task, counter; low_ticks=100, high_ticks=100, ...)
```

### Read Operations

```julia
read(task::AITask; samples_per_channel=-1, timeout=10.0) -> Vector/Matrix{Float64}
read(task::AITask, T; ...) where T  # T in {Float64, Int16, UInt16, Int32, UInt32}
read(task::DITask; ...) -> Vector/Matrix{UInt32}
read(task::DITask, T; ...) where T  # T in {UInt8, UInt16, UInt32}
read(task::CITask; ...) -> Vector{UInt32}
read(task::CITask, Float64; ...) -> Vector{Float64}

read_scalar(task::AITask; timeout=10.0) -> Float64
read_scalar(task::DITask; timeout=10.0) -> UInt32
read_scalar(task::CITask; timeout=10.0) -> UInt32
```

### Write Operations

```julia
write(task::AOTask, data::AbstractVector{Float64}; auto_start=true, timeout=10.0) -> Int
write(task::AOTask, data::AbstractMatrix{Float64}; ...) -> Int
write(task::DOTask, data::AbstractVector{UInt8}; ...) -> Int
write(task::DOTask, data::AbstractVector{UInt16}; ...) -> Int
write(task::DOTask, data::AbstractVector{UInt32}; ...) -> Int

write_scalar(task::AOTask, value::Float64; auto_start=true, timeout=10.0)
write_scalar(task::DOTask, value::UInt32; auto_start=true, timeout=10.0)
```

### Buffer Information

```julia
available_samples(task) -> Int         # Samples available to read
space_available(task) -> Int           # Space in output buffer
total_samples_acquired(task) -> Int
total_samples_generated(task) -> Int
```

### Timing Configuration

```julia
configure_timing!(task; source="", rate=1000.0, active_edge=Rising,
                  sample_mode=FiniteSamples, samples_per_channel=1000)
configure_implicit_timing!(task; sample_mode=FiniteSamples, samples_per_channel=1000)
configure_change_detection_timing!(task; rising_edge_channels="", falling_edge_channels="", ...)
configure_handshaking_timing!(task; ...)
```

### Timing Properties

```julia
sample_rate(task) -> Float64
set_sample_rate!(task, rate)
sample_clock_source(task) -> String
set_sample_clock_source!(task, source)
samples_per_channel(task) -> Int
set_samples_per_channel!(task, count)
```

### Buffer Configuration

```julia
configure_input_buffer!(task, samples_per_channel)
configure_output_buffer!(task, samples_per_channel)
input_buffer_size(task) -> Int
set_input_buffer_size!(task, size)
output_buffer_size(task) -> Int
set_output_buffer_size!(task, size)
```

### Trigger Configuration

```julia
configure_digital_start_trigger!(task, source; edge=Rising)
configure_analog_start_trigger!(task, source; slope=RisingSlope, level=0.0)
configure_analog_window_start_trigger!(task, source; when=:EnteringWindow, window_top=1.0, window_bottom=-1.0)
disable_start_trigger!(task)

configure_digital_ref_trigger!(task, source; edge=Rising, pretrigger_samples=100)
configure_analog_ref_trigger!(task, source; slope=RisingSlope, level=0.0, pretrigger_samples=100)
disable_ref_trigger!(task)
```

### Properties

```julia
channel_type(task, channel_name) -> String
measurement_type(task, channel_name) -> String
get_channel_property(task, channel_name, property_key)
set_channel_property!(task, channel_name, property_key, value)
get_task_property(task, property_key)
set_task_property!(task, property_key, value)
list_channel_properties() -> Vector{String}
list_task_properties() -> Vector{String}
property_info(property_key) -> PropertyDef
get_all_channel_properties(task, channel_name) -> Dict
```

### Library Information

```julia
library_version() -> NIDAQmxVersion
cached_library_version() -> Union{NIDAQmxVersion, Nothing}
is_library_available() -> Bool
```

### Error Handling

```julia
check_error(code)                      # Throws NIDAQError for negative codes
get_error_message(code) -> String
get_extended_error_info() -> String
```

## Common Workflows

### Analog Input Acquisition

```julia
using NIDAQmx

# Create task and configure
task = AITask("Dev1/ai0"; terminal_config=RSE)
configure_timing!(task; rate=10000.0, samples_per_channel=1000, sample_mode=FiniteSamples)

# Acquire data
start!(task)
wait_until_done(task)
data = read(task)
stop!(task)
```

### Continuous Analog Output

```julia
using NIDAQmx

task = AOTask("Dev1/ao0")
configure_timing!(task; rate=10000.0, sample_mode=ContinuousSamples, samples_per_channel=10000)

# Generate sine wave
t = range(0, 1, length=10000)
data = 5.0 .* sin.(2π .* 100 .* t)

write(task, data; auto_start=false)
start!(task)
# ... task runs continuously ...
stop!(task)
```

### Digital I/O

```julia
using NIDAQmx

# Read digital port
di_task = DITask("Dev1/port0")
data = read(di_task, UInt8)

# Write digital port
do_task = DOTask("Dev1/port0")
write(do_task, UInt8[0xFF])
```

### Counter Input (Edge Counting)

```julia
using NIDAQmx

task = CITask("Dev1/ctr0"; method=:count_edges, edge=Rising)
configure_implicit_timing!(task; sample_mode=ContinuousSamples)
start!(task)
counts = read(task; samples_per_channel=100)
stop!(task)
```

### Triggered Acquisition

```julia
using NIDAQmx

task = AITask("Dev1/ai0")
configure_timing!(task; rate=10000.0, samples_per_channel=1000)
configure_digital_start_trigger!(task, "/Dev1/PFI0"; edge=Rising)

start!(task)  # Waits for trigger
wait_until_done(task; timeout=30.0)
data = read(task)
stop!(task)
```

### Multi-Channel Acquisition

```julia
using NIDAQmx

task = AITask()
add_ai_voltage!(task, "Dev1/ai0"; terminal_config=RSE)
add_ai_voltage!(task, "Dev1/ai1"; terminal_config=RSE)
add_ai_voltage!(task, "Dev1/ai2"; terminal_config=RSE)

configure_timing!(task; rate=1000.0, samples_per_channel=100)
start!(task)
data = read(task)  # 100×3 Matrix
stop!(task)
```
