# NIDAQmx.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://LidkeLab.github.io/NIDAQmx.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://LidkeLab.github.io/NIDAQmx.jl/dev/)
[![Build Status](https://github.com/LidkeLab/NIDAQmx.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/LidkeLab/NIDAQmx.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/LidkeLab/NIDAQmx.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/LidkeLab/NIDAQmx.jl)

A Julia wrapper for National Instruments NI-DAQmx driver, providing type-safe access to NI data acquisition hardware.

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/LidkeLab/NIDAQmx.jl")
```

Requires NI-DAQmx driver to be installed on your system.

## Quick Start

```julia
using NIDAQmx

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
- [Full Documentation](https://LidkeLab.github.io/NIDAQmx.jl/dev/) - Guides and examples

## License

MIT License - see [LICENSE](LICENSE) file.
