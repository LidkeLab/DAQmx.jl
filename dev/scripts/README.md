# NIDAQmx Development Scripts

Scripts for testing and debugging NI-DAQmx hardware.

## Scripts

### `list_devices.jl`

Discovers and lists all NI-DAQmx devices with their capabilities.

```bash
julia --project=../.. list_devices.jl
```

Output includes:
- Device name, product type, serial number
- Available analog input/output channels and voltage ranges
- Digital input/output lines and ports
- Counter input/output channels
- Available terminals

### `test_channels.jl`

Interactively tests all channels on a device.

```bash
# Test first available device
julia --project=../.. test_channels.jl

# Test specific device
julia --project=../.. test_channels.jl Dev2
```

**WARNING:** This script writes to outputs! Ensure no sensitive equipment is connected.

Tests performed:
- **Analog Input:** Read voltage from each channel
- **Analog Output:** Write 0V to each channel, generate test waveform
- **Digital Input:** Read state of each port/line
- **Digital Output:** Write 0 to each port, toggle test
- **Counter Input:** Read edge counts
- **Counter Output:** Generate test pulses

## Running from this directory

```bash
cd dev/scripts
julia --project=../.. list_devices.jl
```

Or from the package root:

```bash
julia --project=. dev/scripts/list_devices.jl
```
