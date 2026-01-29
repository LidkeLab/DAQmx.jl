# Test all channels on NI-DAQmx devices
#
# This script attempts to:
# - Read from all analog input channels
# - Write 0V to all analog output channels
# - Read from all digital input lines
# - Write 0 to all digital output lines
# - Read counter inputs
#
# Usage: julia --project=../.. test_channels.jl [device_name]
#
# WARNING: This script writes to outputs! Ensure nothing sensitive is connected.

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))

using NIDAQmx
using Printf

# Configuration
const READ_TIMEOUT = 1.0  # seconds
const WRITE_TIMEOUT = 1.0  # seconds

println("=" ^ 70)
println("NI-DAQmx Channel Test Script")
println("=" ^ 70)
println()
println("WARNING: This script will write to analog and digital outputs!")
println("         Ensure no sensitive equipment is connected.")
println()

# Check library
if !is_library_available()
    println("ERROR: NI-DAQmx library not found!")
    exit(1)
end

println("NI-DAQmx Version: $(library_version())")
println()

# Get devices
devs = devices()
if isempty(devs)
    println("No devices found.")
    exit(0)
end

# Select device
target_device = if length(ARGS) > 0
    ARGS[1]
else
    devs[1].name
end

println("Testing device: $target_device")
println("-" ^ 70)

# Verify device exists
if !any(d -> d.name == target_device, devs)
    println("ERROR: Device '$target_device' not found.")
    println("Available devices: $(join([d.name for d in devs], ", "))")
    exit(1)
end

# Helper function for safe operations
function safe_test(f::Function, description::String)
    print("  $description... ")
    try
        result = f()
        println("OK")
        return result
    catch e
        println("FAILED")
        println("    Error: $(sprint(showerror, e))")
        return nothing
    end
end

# =============================================================================
# Analog Input Tests
# =============================================================================

println("\n" * "=" ^ 70)
println("ANALOG INPUT")
println("=" ^ 70)

ai_chans = ai_channels(target_device)
if isempty(ai_chans)
    println("  No analog input channels available.")
else
    println("  Found $(length(ai_chans)) AI channel(s)")
    println()

    # Test each channel individually
    for chan in ai_chans
        safe_test("Reading $chan") do
            task = AITask(chan; terminal_config=RSE)
            start!(task)
            value = read_scalar(task; timeout=READ_TIMEOUT)
            stop!(task)
            clear!(task)
            @printf("%.4f V", value)
            return value
        end
    end

    # Test reading all channels at once
    if length(ai_chans) > 1
        println()
        safe_test("Reading all AI channels simultaneously") do
            # Create channel range string
            first_chan = ai_chans[1]
            last_chan = ai_chans[end]
            # Extract device and channel numbers
            dev_prefix = split(first_chan, "/")[1]
            first_num = parse(Int, match(r"ai(\d+)", first_chan).captures[1])
            last_num = parse(Int, match(r"ai(\d+)", last_chan).captures[1])
            chan_range = "$dev_prefix/ai$first_num:$last_num"

            task = AITask()
            add_ai_voltage!(task, chan_range; terminal_config=RSE)
            configure_timing!(task; rate=1000.0, samples_per_channel=10)
            start!(task)
            data = read(task; samples_per_channel=10)
            stop!(task)
            clear!(task)
            println("$(size(data)) samples")
            return data
        end
    end
end

# =============================================================================
# Analog Output Tests
# =============================================================================

println("\n" * "=" ^ 70)
println("ANALOG OUTPUT")
println("=" ^ 70)

ao_chans = ao_channels(target_device)
if isempty(ao_chans)
    println("  No analog output channels available.")
else
    println("  Found $(length(ao_chans)) AO channel(s)")
    println()

    # Write 0V to each channel
    for chan in ao_chans
        safe_test("Writing 0.0V to $chan") do
            task = AOTask(chan)
            write_scalar(task, 0.0; timeout=WRITE_TIMEOUT)
            clear!(task)
            return 0.0
        end
    end

    # Test writing a waveform
    println()
    safe_test("Writing test waveform to $(ao_chans[1])") do
        task = AOTask(ao_chans[1])
        # Generate a simple ramp from 0 to 1V and back
        waveform = vcat(collect(0.0:0.1:1.0), collect(1.0:-0.1:0.0))
        configure_timing!(task; rate=100.0, samples_per_channel=length(waveform))
        n = write(task, waveform; auto_start=true)
        wait_until_done(task; timeout=5.0)
        stop!(task)

        # Reset to 0V
        write_scalar(task, 0.0)
        clear!(task)
        println("$n samples")
        return n
    end
end

# =============================================================================
# Digital Input Tests
# =============================================================================

println("\n" * "=" ^ 70)
println("DIGITAL INPUT")
println("=" ^ 70)

di_lns = di_lines(target_device)
di_prts = di_ports(target_device)

if isempty(di_lns)
    println("  No digital input lines available.")
else
    println("  Found $(length(di_lns)) DI line(s) in $(length(di_prts)) port(s)")
    println()

    # Test reading each port
    for port in di_prts
        safe_test("Reading $port") do
            task = DITask(port; line_grouping=ChannelForAllLines)
            value = read_scalar(task; timeout=READ_TIMEOUT)
            clear!(task)
            @printf("0x%08X", value)
            return value
        end
    end

    # Test reading individual lines
    if length(di_lns) <= 8  # Only test if not too many lines
        println()
        for line in di_lns[1:min(4, length(di_lns))]
            safe_test("Reading $line") do
                task = DITask(line)
                value = read_scalar(task; timeout=READ_TIMEOUT)
                clear!(task)
                print(value == 0 ? "LOW" : "HIGH")
                return value
            end
        end
        if length(di_lns) > 4
            println("  ... and $(length(di_lns) - 4) more lines")
        end
    end
end

# =============================================================================
# Digital Output Tests
# =============================================================================

println("\n" * "=" ^ 70)
println("DIGITAL OUTPUT")
println("=" ^ 70)

do_lns = do_lines(target_device)
do_prts = do_ports(target_device)

if isempty(do_lns)
    println("  No digital output lines available.")
else
    println("  Found $(length(do_lns)) DO line(s) in $(length(do_prts)) port(s)")
    println()

    # Write 0 to each port
    for port in do_prts
        safe_test("Writing 0x00 to $port") do
            task = DOTask(port; line_grouping=ChannelForAllLines)
            write_scalar(task, UInt32(0); timeout=WRITE_TIMEOUT)
            clear!(task)
            return 0
        end
    end

    # Test toggling a single line
    if !isempty(do_lns)
        println()
        line = do_lns[1]
        safe_test("Toggle test on $line (LOW->HIGH->LOW)") do
            task = DOTask(line)
            write_scalar(task, UInt32(0))
            sleep(0.1)
            write_scalar(task, UInt32(1))
            sleep(0.1)
            write_scalar(task, UInt32(0))
            clear!(task)
            return true
        end
    end
end

# =============================================================================
# Counter Input Tests
# =============================================================================

println("\n" * "=" ^ 70)
println("COUNTER INPUT")
println("=" ^ 70)

ci_chans = ci_channels(target_device)
if isempty(ci_chans)
    println("  No counter input channels available.")
else
    println("  Found $(length(ci_chans)) CI channel(s)")
    println()

    for ctr in ci_chans
        safe_test("Reading edge count on $ctr") do
            task = CITask(ctr; method=:count_edges, edge=Rising, count_direction=CountUp)
            start!(task)
            sleep(0.1)  # Wait a bit to count any edges
            value = read_scalar(task; timeout=READ_TIMEOUT)
            stop!(task)
            clear!(task)
            print("$value edges")
            return value
        end
    end
end

# =============================================================================
# Counter Output Tests
# =============================================================================

println("\n" * "=" ^ 70)
println("COUNTER OUTPUT")
println("=" ^ 70)

co_chans = co_channels(target_device)
if isempty(co_chans)
    println("  No counter output channels available.")
else
    println("  Found $(length(co_chans)) CO channel(s)")
    println()

    for ctr in co_chans
        safe_test("Generating 10 pulses on $ctr (1kHz)") do
            task = COTask(ctr; method=:pulse_freq, freq=1000.0, duty_cycle=0.5)
            configure_implicit_timing!(task; sample_mode=FiniteSamples, samples_per_channel=10)
            start!(task)
            wait_until_done(task; timeout=5.0)
            stop!(task)
            clear!(task)
            return 10
        end
    end
end

# =============================================================================
# Summary
# =============================================================================

println("\n" * "=" ^ 70)
println("TEST COMPLETE")
println("=" ^ 70)
println()
println("Device: $target_device")
println("  AI channels: $(length(ai_chans))")
println("  AO channels: $(length(ao_chans))")
println("  DI lines:    $(length(di_lns))")
println("  DO lines:    $(length(do_lns))")
println("  CI channels: $(length(ci_chans))")
println("  CO channels: $(length(co_chans))")
println()
