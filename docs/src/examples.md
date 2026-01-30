# Examples

```@meta
CurrentModule = NIDAQmx
```

## Device Discovery

List available devices and query their capabilities:

```julia
using NIDAQmx

# Get all devices
devs = devices()
for dev in devs
    println("Device: $(dev.name)")
    println("  Product: $(product_type(dev))")
    println("  Serial: $(serial_number(dev))")
    println("  AI Channels: $(ai_channels(dev))")
    println("  AO Channels: $(ao_channels(dev))")
    println("  Voltage Ranges: $(ai_voltage_ranges(dev))")
end
```

## Analog Input

### Single Channel Finite Acquisition

```julia
using NIDAQmx

# Create task with convenience constructor
task = AITask("Dev1/ai0"; terminal_config=RSE)

# Configure timing
configure_timing!(task;
    rate=10000.0,
    samples_per_channel=1000,
    sample_mode=FiniteSamples
)

# Acquire data
start!(task)
wait_until_done(task)
data = read(task)
stop!(task)

# data is a Vector{Float64} with 1000 samples
```

### Multi-Channel Acquisition

```julia
using NIDAQmx

# Create empty task and add channels
task = AITask()
add_ai_voltage!(task, "Dev1/ai0"; terminal_config=Differential, min_val=-5.0, max_val=5.0)
add_ai_voltage!(task, "Dev1/ai1"; terminal_config=Differential, min_val=-5.0, max_val=5.0)
add_ai_voltage!(task, "Dev1/ai2"; terminal_config=Differential, min_val=-5.0, max_val=5.0)

configure_timing!(task; rate=1000.0, samples_per_channel=100)
start!(task)
data = read(task)  # 100x3 Matrix{Float64}
stop!(task)
```

### Continuous Acquisition

```julia
using NIDAQmx

task = AITask("Dev1/ai0")
configure_timing!(task;
    rate=10000.0,
    sample_mode=ContinuousSamples,
    samples_per_channel=10000
)

start!(task)

# Read in chunks
for i in 1:10
    n_available = available_samples(task)
    if n_available >= 1000
        data = read(task; samples_per_channel=1000)
        println("Read $(length(data)) samples, total acquired: $(total_samples_acquired(task))")
    end
    sleep(0.1)
end

stop!(task)
```

### Thermocouple Measurement

```julia
using NIDAQmx

task = AITask()
add_ai_thermocouple!(task, "Dev1/ai0";
    min_val=0.0,
    max_val=200.0,
    units=:DegC,
    thermocouple_type=:K_Type,
    cjc_source=:BuiltIn
)

start!(task)
temp = read_scalar(task)
println("Temperature: $temp C")
stop!(task)
```

## Analog Output

### Single Point Output

```julia
using NIDAQmx

task = AOTask("Dev1/ao0"; min_val=0.0, max_val=5.0)
write_scalar(task, 2.5)  # Output 2.5V
```

### Waveform Output

```julia
using NIDAQmx

task = AOTask("Dev1/ao0")
configure_timing!(task;
    rate=10000.0,
    samples_per_channel=10000,
    sample_mode=FiniteSamples
)

# Generate sine wave: 100 Hz, 5V amplitude
t = range(0, 1, length=10000)
waveform = 5.0 .* sin.(2π .* 100 .* t)

write(task, waveform; auto_start=false)
start!(task)
wait_until_done(task)
stop!(task)
```

### Continuous Waveform Generation

```julia
using NIDAQmx

task = AOTask("Dev1/ao0")
configure_timing!(task;
    rate=100000.0,
    sample_mode=ContinuousSamples,
    samples_per_channel=100000
)

# Pre-fill buffer
t = range(0, 1, length=100000)
waveform = 5.0 .* sin.(2π .* 1000 .* t)

write(task, waveform; auto_start=false)
start!(task)

# Task generates continuously until stopped
sleep(5.0)
stop!(task)
```

## Digital I/O

### Reading Digital Lines

```julia
using NIDAQmx

# Read 8 digital lines as a byte
task = DITask("Dev1/port0/line0:7"; line_grouping=ChannelForAllLines)
data = read(task, UInt8)
println("Port value: 0x$(string(data[1], base=16))")
```

### Writing Digital Lines

```julia
using NIDAQmx

task = DOTask("Dev1/port0/line0:7"; line_grouping=ChannelForAllLines)
write(task, UInt8[0xFF])  # All lines high
sleep(1.0)
write(task, UInt8[0x00])  # All lines low
```

### Change Detection

```julia
using NIDAQmx

task = DITask("Dev1/port0/line0:3")
configure_change_detection_timing!(task;
    rising_edge_channels="Dev1/port0/line0:3",
    falling_edge_channels="Dev1/port0/line0:3",
    sample_mode=FiniteSamples,
    samples_per_channel=100
)

start!(task)
# Task generates samples when lines change state
data = read(task; samples_per_channel=100, timeout=30.0)
stop!(task)
```

## Counter Input

### Edge Counting

```julia
using NIDAQmx

task = CITask("Dev1/ctr0"; method=:count_edges, edge=Rising, count_direction=CountUp)
configure_implicit_timing!(task; sample_mode=ContinuousSamples)

start!(task)
sleep(1.0)
count = read_scalar(task)
println("Edges counted: $count")
stop!(task)
```

### Frequency Measurement

```julia
using NIDAQmx

task = CITask("Dev1/ctr0";
    method=:freq,
    min_val=1.0,
    max_val=1000000.0,
    meas_method=:LowFreq1Ctr
)

configure_implicit_timing!(task; sample_mode=FiniteSamples, samples_per_channel=10)
start!(task)
freqs = read(task, Float64; samples_per_channel=10)
println("Measured frequencies: $freqs Hz")
stop!(task)
```

### Angular Encoder

```julia
using NIDAQmx

task = CITask("Dev1/ctr0";
    method=:ang_encoder,
    decoding_type=EncoderX4,
    pulses_per_rev=UInt32(1024),
    z_idx_enable=true,
    z_idx_phase=AHighBHigh,
    units=:Degrees
)

configure_implicit_timing!(task; sample_mode=ContinuousSamples)
start!(task)

for _ in 1:10
    angle = read_scalar(task)
    println("Angle: $angle degrees")
    sleep(0.1)
end

stop!(task)
```

## Counter Output

### Pulse Generation

```julia
using NIDAQmx

# 1 kHz square wave, 50% duty cycle
task = COTask("Dev1/ctr0"; method=:pulse_freq, freq=1000.0, duty_cycle=0.5)
configure_implicit_timing!(task; sample_mode=ContinuousSamples)

start!(task)
sleep(5.0)  # Generate for 5 seconds
stop!(task)
```

### Finite Pulse Train

```julia
using NIDAQmx

task = COTask("Dev1/ctr0"; method=:pulse_freq, freq=100.0, duty_cycle=0.5)
configure_implicit_timing!(task; sample_mode=FiniteSamples, samples_per_channel=10)

start!(task)
wait_until_done(task)  # Wait for 10 pulses
stop!(task)
```

## Triggering

### Digital Start Trigger

```julia
using NIDAQmx

task = AITask("Dev1/ai0")
configure_timing!(task; rate=10000.0, samples_per_channel=1000)
configure_digital_start_trigger!(task, "/Dev1/PFI0"; edge=Rising)

start!(task)  # Task waits for trigger
println("Waiting for trigger on PFI0...")
wait_until_done(task; timeout=30.0)
data = read(task)
stop!(task)
```

### Analog Start Trigger

```julia
using NIDAQmx

task = AITask("Dev1/ai0:1")
configure_timing!(task; rate=10000.0, samples_per_channel=1000)

# Trigger when ai0 crosses 1.0V rising
configure_analog_start_trigger!(task, "Dev1/ai0"; slope=RisingSlope, level=1.0)

start!(task)
wait_until_done(task; timeout=30.0)
data = read(task)
stop!(task)
```

### Reference Trigger (Pre/Post Trigger)

```julia
using NIDAQmx

task = AITask("Dev1/ai0")
configure_timing!(task; rate=10000.0, samples_per_channel=1000)

# Capture 100 samples before and 900 after trigger
configure_digital_ref_trigger!(task, "/Dev1/PFI0";
    edge=Rising,
    pretrigger_samples=100
)

start!(task)
wait_until_done(task)
data = read(task)  # Contains pre and post trigger data
stop!(task)
```

## Synchronized Tasks

### Multi-Task Synchronization

```julia
using NIDAQmx

# Create AI and AO tasks
ai_task = AITask("Dev1/ai0")
ao_task = AOTask("Dev1/ao0")

# Configure both with same timing
configure_timing!(ai_task; rate=10000.0, samples_per_channel=1000, source="/Dev1/ao/SampleClock")
configure_timing!(ao_task; rate=10000.0, samples_per_channel=1000)

# Generate waveform
waveform = sin.(2π .* (0:999) ./ 1000)
write(ao_task, waveform; auto_start=false)

# Start both (AI first since it's slave)
start!(ai_task)
start!(ao_task)

wait_until_done(ao_task)
data = read(ai_task)

stop!(ai_task)
stop!(ao_task)
```
