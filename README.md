# DAQmx.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://LidkeLab.github.io/DAQmx.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://LidkeLab.github.io/DAQmx.jl/dev/)
[![Build Status](https://github.com/LidkeLab/DAQmx.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/LidkeLab/DAQmx.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/LidkeLab/DAQmx.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/LidkeLab/DAQmx.jl)

A Julia wrapper for the NI-DAQmx driver, providing type-safe access to NI data acquisition hardware.

NI-DAQmx is a trademark of National Instruments. This project is not affiliated with or endorsed by National Instruments.

## Installation

```julia
using Pkg
Pkg.add("DAQmx")
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

## Features

- Parametric task types (`AITask`, `AOTask`, `DITask`, `DOTask`, `CITask`, `COTask`) for type-safe dispatch
- Julia enums for terminal configuration, edge detection, sample modes
- Automatic task handle cleanup via finalizers
- Support for analog, digital, and counter I/O
- Timing configuration: sample clock, implicit, change detection
- Trigger support: digital edge, analog edge, analog window

## Documentation

- [API Reference](api_overview.md) - Complete function and type documentation
- [Full Documentation](https://LidkeLab.github.io/DAQmx.jl/dev/) - Guides and examples

## License

MIT License - see [LICENSE](LICENSE) file.
