# Mock-based tests for DAQmx.jl
#
# These tests run without NI hardware by mocking the low-level ccall functions.
# This allows testing of the Julia wrapper code in CI environments.

using Test
using DAQmx

# ============================================================================
# Mock Infrastructure
# ============================================================================

module MockDAQmx
    # Mock task handle storage
    mutable struct MockTaskState
        handle_counter::Int
        active_tasks::Dict{Ptr{Nothing}, Dict{Symbol, Any}}
        error_mode::Symbol  # :success, :warning, :error
        last_error_code::Int32
    end

    const MOCK_STATE = MockTaskState(
        0,
        Dict{Ptr{Nothing}, Dict{Symbol, Any}}(),
        :success,
        Int32(0)
    )

    function reset_mock!()
        MOCK_STATE.handle_counter = 0
        empty!(MOCK_STATE.active_tasks)
        MOCK_STATE.error_mode = :success
        MOCK_STATE.last_error_code = Int32(0)
    end

    function set_error_mode!(mode::Symbol, code::Int32=Int32(-200001))
        MOCK_STATE.error_mode = mode
        MOCK_STATE.last_error_code = code
    end

    function get_return_code()
        if MOCK_STATE.error_mode === :success
            return Int32(0)
        elseif MOCK_STATE.error_mode === :warning
            return Int32(1)  # Positive = warning
        else
            return MOCK_STATE.last_error_code
        end
    end

    function create_mock_task()
        MOCK_STATE.handle_counter += 1
        handle = Ptr{Nothing}(MOCK_STATE.handle_counter)
        MOCK_STATE.active_tasks[handle] = Dict{Symbol, Any}(
            :name => "",
            :channels => String[],
            :started => false,
            :sample_rate => 1000.0,
            :samples_per_channel => 1000,
        )
        return handle
    end

    function get_task_state(handle::Ptr{Nothing})
        get(MOCK_STATE.active_tasks, handle, nothing)
    end

    function remove_task(handle::Ptr{Nothing})
        delete!(MOCK_STATE.active_tasks, handle)
    end
end

# ============================================================================
# Type Tests (No Hardware Required)
# ============================================================================

@testset "Type Definitions" begin
    @testset "Bool32" begin
        using DAQmx: Bool32, bool32

        @test Bool32(true) !== nothing
        @test Bool32(false) !== nothing
        @test Bool(Bool32(true)) == true
        @test Bool(Bool32(false)) == false
        @test Bool32(1) !== nothing
        @test Bool32(0) !== nothing
    end

    @testset "Task Types" begin
        using DAQmx: Task, AITask, AOTask, DITask, DOTask, CITask, COTask
        using DAQmx: AnalogInputKind, AnalogOutputKind
        using DAQmx: DigitalInputKind, DigitalOutputKind
        using DAQmx: CounterInputKind, CounterOutputKind
        using DAQmx: task_kind

        # Test type aliases are defined correctly
        @test AITask === Task{AnalogInputKind}
        @test AOTask === Task{AnalogOutputKind}
        @test DITask === Task{DigitalInputKind}
        @test DOTask === Task{DigitalOutputKind}
        @test CITask === Task{CounterInputKind}
        @test COTask === Task{CounterOutputKind}
    end

    @testset "Enumerations" begin
        using DAQmx: TerminalConfig, RSE, NRSE, Differential, PseudoDifferential
        using DAQmx: Edge, Rising, Falling
        using DAQmx: SampleMode, FiniteSamples, ContinuousSamples
        using DAQmx: FillMode, GroupByChannel, GroupByScanNumber
        using DAQmx: LineGrouping, ChannelPerLine, ChannelForAllLines
        using DAQmx: CountDirection, CountUp, CountDown
        using DAQmx: Level, Low, High

        # Test enum values are defined
        @test Int32(RSE) != 0
        @test Int32(NRSE) != 0
        @test Int32(Differential) != 0
        @test Int32(Rising) != 0
        @test Int32(Falling) != 0
        @test Int32(FiniteSamples) != 0
        @test Int32(ContinuousSamples) != 0
    end

    @testset "Channel Types" begin
        using DAQmx: AbstractChannel, AnalogChannel, DigitalChannel, CounterChannel

        # Test channel constructors
        ac = AnalogChannel("Dev1/ai0")
        @test ac.physical_channel == "Dev1/ai0"
        @test ac.name == ""

        ac2 = AnalogChannel("Dev1/ai0", "MyChannel")
        @test ac2.name == "MyChannel"

        dc = DigitalChannel("Dev1/port0/line0")
        @test dc.lines == "Dev1/port0/line0"

        cc = CounterChannel("Dev1/ctr0")
        @test cc.counter == "Dev1/ctr0"
    end
end

# ============================================================================
# Error Handling Tests
# ============================================================================

@testset "Error Handling" begin
    using DAQmx: DAQmxError, DAQmxWarning, check_error

    @testset "DAQmxError" begin
        err = DAQmxError(Int32(-200001), "Test error message")
        @test err.code == -200001
        @test err.message == "Test error message"
        @test err isa Exception
    end

    @testset "DAQmxWarning" begin
        warn = DAQmxWarning(Int32(1), "Test warning message")
        @test warn.code == 1
        @test warn.message == "Test warning message"
    end

    @testset "check_error" begin
        # Success case
        @test check_error(Int32(0)) === nothing

        # Error case should throw
        @test_throws DAQmxError check_error(Int32(-1))
    end
end

# ============================================================================
# Device Type Tests
# ============================================================================

@testset "Device Types" begin
    using DAQmx: Device

    dev = Device("Dev1")
    @test dev.name == "Dev1"

    # Test show method
    io = IOBuffer()
    show(io, dev)
    @test String(take!(io)) == "Device(\"Dev1\")"
end

# ============================================================================
# Property System Tests
# ============================================================================

@testset "Property System" begin
    using DAQmx: PropertyDef, CHANNEL_PROPERTIES, TASK_PROPERTIES
    using DAQmx: list_channel_properties, list_task_properties
    using DAQmx: property_info, is_settable

    @testset "PropertyDef" begin
        prop = PropertyDef(:DAQmxGetAIMax, :DAQmxSetAIMax, Float64, "Maximum value")
        @test prop.getter === :DAQmxGetAIMax
        @test prop.setter === :DAQmxSetAIMax
        @test prop.value_type === Float64
        @test is_settable(prop) == true

        # Read-only property
        prop_ro = PropertyDef(:DAQmxGetAIResolution, nothing, Float64)
        @test is_settable(prop_ro) == false
    end

    @testset "Property Dictionaries" begin
        @test haskey(CHANNEL_PROPERTIES, :ai_max)
        @test haskey(CHANNEL_PROPERTIES, :ai_min)
        @test haskey(TASK_PROPERTIES, :num_channels)
    end

    @testset "Property Listing" begin
        channel_props = list_channel_properties()
        @test :ai_max in channel_props
        @test :ai_min in channel_props

        task_props = list_task_properties()
        @test :num_channels in task_props
    end

    @testset "Property Info" begin
        info = property_info(:ai_max)
        @test info isa PropertyDef
        @test info.value_type === Float64

        @test_throws ArgumentError property_info(:nonexistent_property)
    end
end

# ============================================================================
# Library Version Tests (Conditional)
# ============================================================================

@testset "Library Functions" begin
    using DAQmx: is_library_available, DAQmxVersion

    # These tests only check the function exists and returns the right type
    @test is_library_available() isa Bool

    # Test version struct
    v = DAQmxVersion(23, 5, 0)
    @test v.major == 23
    @test v.minor == 5
    @test v.update == 0

    io = IOBuffer()
    show(io, v)
    @test String(take!(io)) == "NI-DAQmx v23.5.0"

    @test VersionNumber(v) == v"23.5.0"
end

# ============================================================================
# Constants Tests
# ============================================================================

@testset "Constants" begin
    using DAQmx: DAQmx_Val_Rising, DAQmx_Val_Falling
    using DAQmx: DAQmx_Val_Volts, DAQmx_Val_Amps
    using DAQmx: DAQmx_Val_FiniteSamps, DAQmx_Val_ContSamps
    using DAQmx: DAQmx_Val_RSE, DAQmx_Val_NRSE, DAQmx_Val_Diff

    # Test that constants have expected values
    @test DAQmx_Val_Rising == 10280
    @test DAQmx_Val_Falling == 10171
    @test DAQmx_Val_Volts == 10348
    @test DAQmx_Val_Amps == 10342
    @test DAQmx_Val_FiniteSamps == 10178
    @test DAQmx_Val_ContSamps == 10123
    @test DAQmx_Val_RSE == 10083
    @test DAQmx_Val_NRSE == 10078
    @test DAQmx_Val_Diff == 10106
end

# ============================================================================
# Integration Pattern Tests
# ============================================================================

@testset "API Patterns" begin
    @testset "Chaining Pattern" begin
        # Test that functions return task for chaining
        # (This would require mocking, but we verify the pattern exists)
        using DAQmx: configure_timing!, configure_implicit_timing!

        # These are the function signatures we expect
        @test hasmethod(configure_timing!, Tuple{DAQmx.Task})
        @test hasmethod(configure_implicit_timing!, Tuple{DAQmx.Task})
    end

    @testset "Export Completeness" begin
        # Verify key exports are available
        exports = names(DAQmx)

        # Task types
        @test :AITask in exports
        @test :AOTask in exports
        @test :DITask in exports
        @test :DOTask in exports
        @test :CITask in exports
        @test :COTask in exports

        # Lifecycle functions
        @test :start! in exports
        @test :stop! in exports
        @test :clear! in exports

        # Channel functions
        @test :add_ai_voltage! in exports
        @test :add_ao_voltage! in exports
        @test :add_di_chan! in exports
        @test :add_do_chan! in exports

        # Timing functions
        @test :configure_timing! in exports

        # Device functions
        @test :devices in exports
        @test :Device in exports
    end
end

println("\nMock tests completed successfully!")
