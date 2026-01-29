using Test

# Run mock tests first (these don't require hardware)
@testset "NIDAQmx.jl Tests" begin
    @testset "Mock Tests (No Hardware)" begin
        include("test_mock.jl")
    end

    # Hardware tests only run if NI-DAQmx is available and hardware is detected
    using NIDAQmx

    if is_library_available()
        @testset "Hardware Tests" begin
            include("test_hardware.jl")
        end
    else
        @info "NI-DAQmx library not available, skipping hardware tests"
    end
end
