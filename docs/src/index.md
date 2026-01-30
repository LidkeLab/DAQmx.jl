```@meta
CurrentModule = DAQmx
```

# DAQmx.jl

A Julia wrapper for National Instruments NI-DAQmx driver, providing type-safe access to NI data acquisition hardware.

## Features

- Parametric task types (`AITask`, `AOTask`, `DITask`, `DOTask`, `CITask`, `COTask`) for type-safe dispatch
- Julia enums for terminal configuration, edge detection, sample modes
- Automatic task handle cleanup via finalizers
- Support for analog, digital, and counter I/O
- Timing configuration: sample clock, implicit, change detection
- Trigger support: digital edge, analog edge, analog window

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/LidkeLab/DAQmx.jl")
```

Requires NI-DAQmx driver to be installed on your system.

## Quick Start

```julia
using DAQmx

# List available devices
devs = devices()

# Analog input: read 100 samples at 1 kHz
task = AITask("Dev1/ai0")
configure_timing!(task; rate=1000.0, samples_per_channel=100)
start!(task)
data = read(task)
stop!(task)

# Analog output: write a sine wave
task = AOTask("Dev1/ao0")
write(task, sin.(2π .* (0:99) ./ 100))
```

## Task Types

DAQmx.jl uses parametric types to enable type-safe dispatch:

| Type Alias | Task Kind | Use |
|------------|-----------|-----|
| `AITask` | `Task{AnalogInputKind}` | Analog voltage/current/temperature input |
| `AOTask` | `Task{AnalogOutputKind}` | Analog voltage/current output |
| `DITask` | `Task{DigitalInputKind}` | Digital line/port input |
| `DOTask` | `Task{DigitalOutputKind}` | Digital line/port output |
| `CITask` | `Task{CounterInputKind}` | Edge counting, frequency, period, encoders |
| `COTask` | `Task{CounterOutputKind}` | Pulse generation |

## Documentation

- [Examples](@ref) - Detailed usage examples
- [API Reference](@ref) - Complete API documentation
