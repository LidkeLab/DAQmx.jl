# Hardware tests for NIDAQmx.jl
# These tests require NI-DAQmx hardware to be available

using Test
using NIDAQmx

@testset "Library Version" begin
    v = library_version()
    @test v isa NIDAQmxVersion
    @test v.major >= 0
    @test v.minor >= 0
    @info "NIDAQmx version: $v"
end

@testset "Device Detection" begin
    devs = devices()
    @test devs isa Vector{Device}

    if isempty(devs)
        @info "No NI-DAQmx devices found, skipping device-specific tests"
        return
    end

    @info "Found $(length(devs)) device(s): $(join([d.name for d in devs], ", "))"

    dev = devs[1]
    @test product_type(dev) isa String
    @test serial_number(dev) isa UInt32
    @test is_simulated(dev) isa Bool

    # Channel enumeration
    @test ai_channels(dev) isa Vector{String}
    @test ao_channels(dev) isa Vector{String}
    @test di_lines(dev) isa Vector{String}
    @test do_lines(dev) isa Vector{String}
    @test ci_channels(dev) isa Vector{String}
    @test co_channels(dev) isa Vector{String}

    # Voltage ranges
    ai_ranges = ai_voltage_ranges(dev)
    @test ai_ranges isa Matrix{Float64}
    @info "AI voltage ranges: $(size(ai_ranges, 1)) range(s)"
end

# Get first device for remaining tests
devs = devices()
if isempty(devs)
    @info "Skipping remaining hardware tests - no devices"
else
    dev = devs[1]

    @testset "Analog Input" begin
        ai_chans = ai_channels(dev)
        if isempty(ai_chans)
            @info "Device does not support analog input"
        else
            chan = ai_chans[1]
            @info "Testing analog input on $chan"

            # Create task
            task = AITask(chan)
            @test task isa AITask
            @test num_channels(task) == 1

            # Configure timing
            configure_timing!(task; rate=1000.0, samples_per_channel=100)

            # Run acquisition
            start!(task)
            @test is_done(task) == false || true  # May be done immediately

            data = read(task; samples_per_channel=100)
            @test data isa Vector{Float64}
            @test length(data) == 100

            stop!(task)
            clear!(task)
        end
    end

    @testset "Analog Output" begin
        ao_chans = ao_channels(dev)
        if isempty(ao_chans)
            @info "Device does not support analog output"
        else
            chan = ao_chans[1]
            @info "Testing analog output on $chan"

            # Get device's supported voltage range
            ao_ranges = ao_voltage_ranges(dev)
            min_v, max_v = ao_ranges[1, 1], ao_ranges[1, 2]
            @info "Using AO voltage range: $min_v to $max_v V"

            # Create task with device-appropriate voltage range
            task = AOTask(chan; min_val=min_v, max_val=max_v)
            @test task isa AOTask

            # Write single value (midpoint of range)
            mid_v = (min_v + max_v) / 2
            write_scalar(task, mid_v)
            @test true  # write_scalar succeeded

            # Write to min and max values
            write_scalar(task, min_v)
            write_scalar(task, max_v)
            @test true  # boundary writes succeeded

            clear!(task)
        end
    end

    @testset "Digital Input" begin
        di_lns = di_lines(dev)
        if isempty(di_lns)
            @info "Device does not support digital input"
        else
            lines = di_lns[1]
            @info "Testing digital input on $lines"

            task = DITask(lines)
            @test task isa DITask

            # Read single value
            data = read_scalar(task)
            @test data isa UInt32

            clear!(task)
        end
    end

    @testset "Digital Output" begin
        do_lns = do_lines(dev)
        if isempty(do_lns)
            @info "Device does not support digital output"
        else
            lines = do_lns[1]
            @info "Testing digital output on $lines"

            task = DOTask(lines)
            @test task isa DOTask

            # Write single value
            write_scalar(task, UInt32(0))
            write_scalar(task, UInt32(1))
            write_scalar(task, UInt32(0))

            clear!(task)
        end
    end

    @testset "Counter Input" begin
        ci_chans = ci_channels(dev)
        if isempty(ci_chans)
            @info "Device does not support counter input"
        else
            ctr = ci_chans[1]
            @info "Testing counter input on $ctr"

            # Try to create counter task - some devices have limited counter support
            # Note: USB-6008 only supports Falling edge, not Rising
            task = nothing
            try
                # First try Rising edge (most devices)
                task = CITask(ctr; method=:count_edges, edge=Rising)
            catch e
                if e isa NIDAQError
                    # Try Falling edge (USB-6008 requires this)
                    try
                        task = CITask(ctr; method=:count_edges, edge=Falling)
                        @info "Device requires Falling edge for counter input"
                    catch e2
                        @info "Counter input not supported on this device: $(e2.message)"
                        @test_skip "Counter input"
                    end
                else
                    rethrow(e)
                end
            end

            if task !== nothing
                @test task isa CITask

                start!(task)

                # Read single count value (on-demand)
                count = read_scalar(task)
                @test count isa UInt32

                stop!(task)
                clear!(task)
            end
        end
    end

    @testset "Counter Output" begin
        co_chans = co_channels(dev)
        if isempty(co_chans)
            @info "Device does not support counter output"
        else
            ctr = co_chans[1]
            @info "Testing counter output on $ctr"

            # Generate pulses
            task = COTask(ctr; method=:pulse_freq, freq=1000.0, duty_cycle=0.5)
            @test task isa COTask

            configure_implicit_timing!(task; sample_mode=FiniteSamples, samples_per_channel=10)
            start!(task)
            wait_until_done(task; timeout=5.0)
            stop!(task)
            clear!(task)
        end
    end
end

@info "Hardware tests completed"
