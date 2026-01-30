# API Reference

```@meta
CurrentModule = NIDAQmx
```

```@index
Pages = ["api.md"]
```

## Task Types

```@docs
Task
TaskKind
```

## Channel Types

```@docs
AbstractChannel
AnalogChannel
DigitalChannel
CounterChannel
```

## Enumerations

```@docs
TerminalConfig
Edge
SampleMode
FillMode
LineGrouping
CountDirection
Level
Coupling
EncoderType
ZIndexPhase
ExcitationSource
ResistanceConfig
Slope
```

## Device Functions

```@docs
Device
devices
product_type
product_number
serial_number
is_simulated
ai_channels
ao_channels
di_lines
do_lines
di_ports
do_ports
ci_channels
co_channels
terminals
ai_voltage_ranges
ao_voltage_ranges
ai_current_ranges
ao_current_ranges
self_calibrate!
reset!
```

## Task Lifecycle

```@docs
start!
stop!
clear!
wait_until_done
is_done
control!
num_channels
task_name
channel_names
device_names
```

## Analog Input Channels

```@docs
add_ai_voltage!
add_ai_current!
add_ai_thermocouple!
add_ai_rtd!
add_ai_resistance!
add_ai_accel!
```

## Analog Output Channels

```@docs
add_ao_voltage!
add_ao_current!
add_ao_funcgen!
```

## Digital Channels

```@docs
add_di_chan!
add_do_chan!
```

## Counter Input Channels

```@docs
add_ci_count_edges!
add_ci_freq!
add_ci_period!
add_ci_pulse_width!
add_ci_two_edge_sep!
add_ci_ang_encoder!
add_ci_lin_encoder!
```

## Counter Output Channels

```@docs
add_co_pulse_freq!
add_co_pulse_time!
add_co_pulse_ticks!
```

## Read/Write Operations

```@docs
read_scalar
write_scalar
available_samples
space_available
total_samples_acquired
total_samples_generated
```

## Timing Configuration

```@docs
configure_timing!
configure_implicit_timing!
configure_change_detection_timing!
configure_handshaking_timing!
sample_rate
set_sample_rate!
sample_clock_source
set_sample_clock_source!
samples_per_channel
set_samples_per_channel!
```

## Buffer Configuration

```@docs
configure_input_buffer!
configure_output_buffer!
input_buffer_size
set_input_buffer_size!
output_buffer_size
set_output_buffer_size!
```

## Trigger Configuration

```@docs
configure_digital_start_trigger!
configure_analog_start_trigger!
configure_analog_window_start_trigger!
disable_start_trigger!
configure_digital_ref_trigger!
configure_analog_ref_trigger!
disable_ref_trigger!
```

## Properties

```@docs
PropertyDef
channel_type
measurement_type
get_channel_property
set_channel_property!
get_task_property
set_task_property!
list_channel_properties
list_task_properties
property_info
get_all_channel_properties
```

## Library Information

```@docs
NIDAQmxVersion
library_version
cached_library_version
is_library_available
```

## Error Handling

```@docs
NIDAQError
NIDAQWarning
check_error
get_error_message
get_extended_error_info
```
