# List all available NI-DAQmx devices and their capabilities
#
# Usage: julia --project=../.. list_devices.jl

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))

using DAQmx

println("=" ^ 60)
println("NI-DAQmx Device Discovery")
println("=" ^ 60)

# Check library availability
if !is_library_available()
    println("\nERROR: NI-DAQmx library not found!")
    println("Please ensure NI-DAQmx is installed on this system.")
    exit(1)
end

# Print library version
v = library_version()
println("\nNI-DAQmx Version: $(v.major).$(v.minor).$(v.update)")

# Get all devices
devs = devices()

if isempty(devs)
    println("\nNo NI-DAQmx devices found.")
    println("Check that your hardware is connected and drivers are installed.")
    exit(0)
end

println("\nFound $(length(devs)) device(s):\n")

for (i, dev) in enumerate(devs)
    println("-" ^ 60)
    println("Device $i: $(dev.name)")
    println("-" ^ 60)

    # Basic info
    try
        println("  Product Type:   $(product_type(dev))")
        println("  Serial Number:  $(serial_number(dev))")
        println("  Simulated:      $(is_simulated(dev))")
    catch e
        println("  (Could not read device info: $e)")
    end

    # Analog Input
    println("\n  Analog Input Channels:")
    ai = ai_channels(dev)
    if isempty(ai)
        println("    (none)")
    else
        println("    $(length(ai)) channel(s): $(first(ai)) ... $(last(ai))")
        try
            ranges = ai_voltage_ranges(dev)
            if !isempty(ranges)
                println("    Voltage ranges:")
                for r in 1:size(ranges, 1)
                    println("      [$(ranges[r,1]), $(ranges[r,2])] V")
                end
            end
        catch
        end
    end

    # Analog Output
    println("\n  Analog Output Channels:")
    ao = ao_channels(dev)
    if isempty(ao)
        println("    (none)")
    else
        println("    $(length(ao)) channel(s): $(first(ao)) ... $(last(ao))")
        try
            ranges = ao_voltage_ranges(dev)
            if !isempty(ranges)
                println("    Voltage ranges:")
                for r in 1:size(ranges, 1)
                    println("      [$(ranges[r,1]), $(ranges[r,2])] V")
                end
            end
        catch
        end
    end

    # Digital Input
    println("\n  Digital Input:")
    di = di_lines(dev)
    di_p = di_ports(dev)
    if isempty(di)
        println("    (none)")
    else
        println("    $(length(di)) line(s)")
        println("    $(length(di_p)) port(s): $(join(di_p, ", "))")
    end

    # Digital Output
    println("\n  Digital Output:")
    do_l = do_lines(dev)
    do_p = do_ports(dev)
    if isempty(do_l)
        println("    (none)")
    else
        println("    $(length(do_l)) line(s)")
        println("    $(length(do_p)) port(s): $(join(do_p, ", "))")
    end

    # Counter Input
    println("\n  Counter Input Channels:")
    ci = ci_channels(dev)
    if isempty(ci)
        println("    (none)")
    else
        println("    $(length(ci)) channel(s): $(join(ci, ", "))")
    end

    # Counter Output
    println("\n  Counter Output Channels:")
    co = co_channels(dev)
    if isempty(co)
        println("    (none)")
    else
        println("    $(length(co)) channel(s): $(join(co, ", "))")
    end

    # Terminals
    println("\n  Available Terminals:")
    terms = terminals(dev)
    if isempty(terms)
        println("    (none)")
    else
        println("    $(length(terms)) terminal(s)")
        # Show first few
        for t in terms[1:min(5, length(terms))]
            println("      $t")
        end
        if length(terms) > 5
            println("      ... and $(length(terms) - 5) more")
        end
    end

    println()
end

println("=" ^ 60)
println("Discovery complete.")
println("=" ^ 60)
