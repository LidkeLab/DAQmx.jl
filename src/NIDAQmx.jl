"""
    NIDAQmx

A Julia wrapper for National Instruments NI-DAQmx driver.

This package provides a clean, type-safe interface to NI data acquisition hardware.
It uses parametric types for task types and explicit error handling.

# Basic Usage

```julia
using NIDAQmx

# List available devices
devs = devices()

# Analog Input
task = AITask("Dev1/ai0")
configure_timing!(task; rate=1000.0, samples_per_channel=100)
start!(task)
data = read(task)
stop!(task)

# Analog Output
task = AOTask("Dev1/ao0")
write(task, sin.(2π .* (0:99) ./ 100))

# Digital I/O
task = DITask("Dev1/port0/line0:7")
data = read(task)

# Counter Input
task = CITask("Dev1/ctr0"; method=:count_edges)
configure_implicit_timing!(task; sample_mode=ContinuousSamples)
start!(task)
counts = read(task)
```

See the documentation for more detailed usage examples.
"""
module NIDAQmx

using Base: unsafe_string

# ============================================================================
# Generated bindings (types, constants, functions)
# ============================================================================

include("generated/types.jl")
include("generated/constants.jl")
include("generated/functions.jl")

# ============================================================================
# Core functionality
# ============================================================================

include("errors.jl")
include("library.jl")
include("types.jl")
include("tasks.jl")
include("devices.jl")

# ============================================================================
# Channel creation
# ============================================================================

include("channels/analog.jl")
include("channels/digital.jl")
include("channels/counter.jl")

# ============================================================================
# I/O and timing
# ============================================================================

include("io.jl")
include("timing.jl")
include("properties.jl")

# ============================================================================
# Exports
# ============================================================================

# Task types
export Task, TaskKind
export AITask, AOTask, DITask, DOTask, CITask, COTask
export AnalogInputKind, AnalogOutputKind
export DigitalInputKind, DigitalOutputKind
export CounterInputKind, CounterOutputKind

# Task lifecycle
export start!, stop!, clear!
export wait_until_done, is_done
export control!, num_channels
export task_name, channel_names, device_names

# Channel types
export AbstractChannel, AnalogChannel, DigitalChannel, CounterChannel

# Enumerations
export TerminalConfig, TerminalDefault, RSE, NRSE, Differential, PseudoDifferential
export Edge, Rising, Falling
export SampleMode, FiniteSamples, ContinuousSamples, HardwareTimedSinglePoint
export FillMode, GroupByChannel, GroupByScanNumber
export LineGrouping, ChannelPerLine, ChannelForAllLines
export CountDirection, CountUp, CountDown, ExternallyControlled
export Level, Low, High
export Coupling, CouplingAC, CouplingDC, CouplingGND
export EncoderType, EncoderX1, EncoderX2, EncoderX4, TwoPulseCounting
export ZIndexPhase, AHighBHigh, AHighBLow, ALowBHigh, ALowBLow
export ExcitationSource, ExcitationInternal, ExcitationExternal, ExcitationDefault
export ResistanceConfig, TwoWire, ThreeWire, FourWire
export TriggerType, Slope, RisingSlope, FallingSlope

# Devices
export Device, devices, device_names
export product_type, product_number, serial_number, is_simulated
export ai_channels, ao_channels, di_lines, do_lines, di_ports, do_ports
export ci_channels, co_channels, terminals
export ai_voltage_ranges, ao_voltage_ranges, ai_current_ranges, ao_current_ranges
export self_calibrate!, reset!

# Analog channels
export add_ai_voltage!, add_ai_current!, add_ai_thermocouple!
export add_ai_rtd!, add_ai_resistance!, add_ai_accel!
export add_ao_voltage!, add_ao_current!, add_ao_funcgen!

# Digital channels
export add_di_chan!, add_do_chan!

# Counter channels
export add_ci_count_edges!, add_ci_freq!, add_ci_period!
export add_ci_pulse_width!, add_ci_two_edge_sep!
export add_ci_ang_encoder!, add_ci_lin_encoder!
export add_co_pulse_freq!, add_co_pulse_time!, add_co_pulse_ticks!

# I/O operations
export read_scalar, write_scalar
export available_samples, space_available
export total_samples_acquired, total_samples_generated

# Timing configuration
export configure_timing!, configure_implicit_timing!
export configure_change_detection_timing!, configure_handshaking_timing!
export configure_digital_start_trigger!, configure_analog_start_trigger!
export configure_analog_window_start_trigger!, disable_start_trigger!
export configure_digital_ref_trigger!, configure_analog_ref_trigger!
export disable_ref_trigger!
export sample_rate, set_sample_rate!
export sample_clock_source, set_sample_clock_source!
export samples_per_channel, set_samples_per_channel!
export configure_input_buffer!, configure_output_buffer!
export input_buffer_size, set_input_buffer_size!
export output_buffer_size, set_output_buffer_size!

# Properties
export PropertyDef, CHANNEL_PROPERTIES, TASK_PROPERTIES
export channel_type, measurement_type
export get_channel_property, set_channel_property!
export get_task_property, set_task_property!
export list_channel_properties, list_task_properties
export property_info, get_all_channel_properties

# Library information
export library_version, is_library_available, cached_library_version
export NIDAQmxVersion

# Error handling
export NIDAQError, NIDAQWarning
export check_error, get_error_message, get_extended_error_info

# ============================================================================
# Module initialization
# ============================================================================

function __init__()
    __init_library__()
end

end # module NIDAQmx
