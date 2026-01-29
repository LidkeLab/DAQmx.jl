# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NIDAQmx.jl is a Julia wrapper for National Instruments NI-DAQmx driver, providing type-safe access to NI data acquisition hardware. The package uses parametric types for tasks and Julia enums instead of raw constants.

## Development Commands

```bash
# Run all tests (mock tests run always, hardware tests require NI-DAQmx library)
julia --project -e 'using Pkg; Pkg.test()'

# Run only mock tests (no hardware required)
julia --project test/test_mock.jl

# Build documentation
julia --project=docs docs/make.jl

# Regenerate bindings from NIDAQmx.h (requires Clang.jl and NI-DAQmx SDK)
julia --project=gen gen/generator.jl
```

## Architecture

### Parametric Task Types
Tasks are parameterized by kind to enable type-safe dispatch:
```
Task{K<:TaskKind} where K in {AnalogInputKind, AnalogOutputKind, DigitalInputKind, DigitalOutputKind, CounterInputKind, CounterOutputKind}
```
Type aliases: `AITask`, `AOTask`, `DITask`, `DOTask`, `CITask`, `COTask`

### Source Organization
- `src/generated/` - Auto-generated from NIDAQmx.h via Clang.jl (types.jl, constants.jl, functions.jl)
- `src/library.jl` - Library loading and version detection
- `src/errors.jl` - Error handling with `@check` macro that wraps all DAQmx calls
- `src/types.jl` - Task types, channel types, and Julia enums (TerminalConfig, Edge, SampleMode, etc.)
- `src/tasks.jl` - Task lifecycle (start!, stop!, clear!, wait_until_done)
- `src/devices.jl` - Device enumeration and property queries
- `src/channels/` - Channel creation functions (analog.jl, digital.jl, counter.jl)
- `src/io.jl` - Read/write operations extending Base.read/Base.write
- `src/timing.jl` - Timing and trigger configuration
- `src/properties.jl` - Property system for getting/setting channel and task attributes

### Key Patterns
- **Error handling**: All DAQmx calls are wrapped with `@check` macro which calls `check_error()` - negative codes throw `NIDAQError`, positive codes log warnings
- **Task finalizers**: Tasks register finalizers to auto-cleanup handles via `DAQmxClearTask`
- **Channel functions return task**: Functions like `add_ai_voltage!` return the task for method chaining
- **Library availability**: `is_library_available()` checks if NI-DAQmx is installed; tests and code paths adapt accordingly

### Generated Bindings
The `gen/` directory contains Clang.jl configuration. Bindings are pre-generated and committed; regeneration requires:
1. NI-DAQmx SDK installed with header file
2. Update paths in `gen/generator.toml` if needed
3. Run `julia --project=gen gen/generator.jl`

### Testing Strategy
- `test/test_mock.jl` - Tests type definitions, enums, error handling, and API patterns without hardware
- `test/test_hardware.jl` - Integration tests requiring NI-DAQmx hardware (skipped if library unavailable or no devices detected)
