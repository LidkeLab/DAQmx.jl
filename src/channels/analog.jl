# Analog channel functions for DAQmx.jl

"""
    add_ai_voltage!(task::AITask, channel::String;
                    terminal_config::TerminalConfig=Differential,
                    min_val::Float64=-10.0,
                    max_val::Float64=10.0,
                    units::Symbol=:Volts,
                    name::String="",
                    custom_scale::String="")

Add an analog input voltage channel to the task.

# Arguments
- `task::AITask`: The analog input task.
- `channel::String`: Physical channel name (e.g., "Dev1/ai0" or "Dev1/ai0:3").

# Keyword Arguments
- `terminal_config::TerminalConfig`: Terminal configuration (default: `Differential`).
  Options: `TerminalDefault`, `RSE`, `NRSE`, `Differential`, `PseudoDifferential`.
- `min_val::Float64`: Minimum expected value in units (default: -10.0).
- `max_val::Float64`: Maximum expected value in units (default: 10.0).
- `units::Symbol`: Units for the measurement (default: `:Volts`).
  Options: `:Volts`, `:FromCustomScale`.
- `name::String`: Name to assign to the channel (default: "").
- `custom_scale::String`: Name of custom scale to use if units is `:FromCustomScale`.

# Example
```julia
task = AITask()
add_ai_voltage!(task, "Dev1/ai0"; terminal_config=RSE, min_val=-5.0, max_val=5.0)
add_ai_voltage!(task, "Dev1/ai1"; terminal_config=RSE, min_val=-5.0, max_val=5.0)
```
"""
function add_ai_voltage!(task::AITask, channel::String;
                         terminal_config::TerminalConfig=Differential,
                         min_val::Float64=-10.0,
                         max_val::Float64=10.0,
                         units::Symbol=:Volts,
                         name::String="",
                         custom_scale::String="")

    units_code = if units === :Volts
        DAQmx_Val_Volts
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units. Expected :Volts or :FromCustomScale"))
    end

    @check DAQmxCreateAIVoltageChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        Int32(terminal_config),
        min_val,
        max_val,
        Int32(units_code),
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ai_current!(task::AITask, channel::String;
                    terminal_config::TerminalConfig=Differential,
                    min_val::Float64=-0.01,
                    max_val::Float64=0.01,
                    units::Symbol=:Amps,
                    shunt_resistor_loc::Symbol=:Default,
                    ext_shunt_resistor_val::Float64=249.0,
                    name::String="",
                    custom_scale::String="")

Add an analog input current channel to the task.

# Arguments
- `task::AITask`: The analog input task.
- `channel::String`: Physical channel name.

# Keyword Arguments
- `terminal_config::TerminalConfig`: Terminal configuration (default: `Differential`).
- `min_val::Float64`: Minimum expected current in units (default: -0.01).
- `max_val::Float64`: Maximum expected current in units (default: 0.01).
- `units::Symbol`: Units for the measurement (default: `:Amps`).
- `shunt_resistor_loc::Symbol`: Location of shunt resistor (`:Default`, `:Internal`, `:External`).
- `ext_shunt_resistor_val::Float64`: External shunt resistor value in ohms.
- `name::String`: Name to assign to the channel.
- `custom_scale::String`: Name of custom scale.
"""
function add_ai_current!(task::AITask, channel::String;
                         terminal_config::TerminalConfig=Differential,
                         min_val::Float64=-0.01,
                         max_val::Float64=0.01,
                         units::Symbol=:Amps,
                         shunt_resistor_loc::Symbol=:Default,
                         ext_shunt_resistor_val::Float64=249.0,
                         name::String="",
                         custom_scale::String="")

    units_code = if units === :Amps
        DAQmx_Val_Amps
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    shunt_loc_code = if shunt_resistor_loc === :Default
        DAQmx_Val_Default
    elseif shunt_resistor_loc === :Internal
        DAQmx_Val_Internal
    elseif shunt_resistor_loc === :External
        DAQmx_Val_External
    else
        throw(ArgumentError("Unknown shunt_resistor_loc: $shunt_resistor_loc"))
    end

    @check DAQmxCreateAICurrentChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        Int32(terminal_config),
        min_val,
        max_val,
        Int32(units_code),
        Int32(shunt_loc_code),
        ext_shunt_resistor_val,
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ai_thermocouple!(task::AITask, channel::String;
                         min_val::Float64=0.0,
                         max_val::Float64=100.0,
                         units::Symbol=:DegC,
                         thermocouple_type::Symbol=:K_Type,
                         cjc_source::Symbol=:BuiltIn,
                         cjc_val::Float64=25.0,
                         cjc_channel::String="",
                         name::String="")

Add a thermocouple input channel to the task.

# Keyword Arguments
- `units::Symbol`: Temperature units (`:DegC`, `:DegF`, `:Kelvins`, `:DegR`).
- `thermocouple_type::Symbol`: Type of thermocouple (`:J_Type`, `:K_Type`, `:N_Type`, `:R_Type`, `:S_Type`, `:T_Type`, `:B_Type`, `:E_Type`).
- `cjc_source::Symbol`: Cold junction compensation source (`:BuiltIn`, `:ConstVal`, `:Chan`).
- `cjc_val::Float64`: Cold junction temperature if cjc_source is `:ConstVal`.
- `cjc_channel::String`: CJC channel name if cjc_source is `:Chan`.
"""
function add_ai_thermocouple!(task::AITask, channel::String;
                              min_val::Float64=0.0,
                              max_val::Float64=100.0,
                              units::Symbol=:DegC,
                              thermocouple_type::Symbol=:K_Type,
                              cjc_source::Symbol=:BuiltIn,
                              cjc_val::Float64=25.0,
                              cjc_channel::String="",
                              name::String="")

    units_code = if units === :DegC
        DAQmx_Val_DegC
    elseif units === :DegF
        DAQmx_Val_DegF
    elseif units === :Kelvins
        DAQmx_Val_Kelvins
    elseif units === :DegR
        DAQmx_Val_DegR
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    tc_type_code = if thermocouple_type === :J_Type
        DAQmx_Val_J_Type_TC
    elseif thermocouple_type === :K_Type
        DAQmx_Val_K_Type_TC
    elseif thermocouple_type === :N_Type
        DAQmx_Val_N_Type_TC
    elseif thermocouple_type === :R_Type
        DAQmx_Val_R_Type_TC
    elseif thermocouple_type === :S_Type
        DAQmx_Val_S_Type_TC
    elseif thermocouple_type === :T_Type
        DAQmx_Val_T_Type_TC
    elseif thermocouple_type === :B_Type
        DAQmx_Val_B_Type_TC
    elseif thermocouple_type === :E_Type
        DAQmx_Val_E_Type_TC
    else
        throw(ArgumentError("Unknown thermocouple_type: $thermocouple_type"))
    end

    cjc_source_code = if cjc_source === :BuiltIn
        DAQmx_Val_Internal
    elseif cjc_source === :ConstVal
        DAQmx_Val_External  # Const value uses a fixed value
    elseif cjc_source === :Chan
        10232  # DAQmx_Val_Chan
    else
        throw(ArgumentError("Unknown cjc_source: $cjc_source"))
    end

    @check DAQmxCreateAIThrmcplChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        min_val,
        max_val,
        Int32(units_code),
        Int32(tc_type_code),
        Int32(cjc_source_code),
        cjc_val,
        isempty(cjc_channel) ? NULLSTR : _cstr(cjc_channel)
    )

    return task
end

"""
    add_ai_rtd!(task::AITask, channel::String;
                min_val::Float64=0.0,
                max_val::Float64=100.0,
                units::Symbol=:DegC,
                rtd_type::Symbol=:Pt3851,
                resistance_config::ResistanceConfig=FourWire,
                current_excit_source::ExcitationSource=ExcitationInternal,
                current_excit_val::Float64=0.001,
                r0::Float64=100.0,
                name::String="")

Add an RTD (Resistance Temperature Detector) input channel.
"""
function add_ai_rtd!(task::AITask, channel::String;
                     min_val::Float64=0.0,
                     max_val::Float64=100.0,
                     units::Symbol=:DegC,
                     rtd_type::Symbol=:Pt3851,
                     resistance_config::ResistanceConfig=FourWire,
                     current_excit_source::ExcitationSource=ExcitationInternal,
                     current_excit_val::Float64=0.001,
                     r0::Float64=100.0,
                     name::String="")

    units_code = if units === :DegC
        DAQmx_Val_DegC
    elseif units === :DegF
        DAQmx_Val_DegF
    elseif units === :Kelvins
        DAQmx_Val_Kelvins
    elseif units === :DegR
        DAQmx_Val_DegR
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    rtd_type_code = if rtd_type === :Pt3750
        DAQmx_Val_Pt3750
    elseif rtd_type === :Pt3851
        DAQmx_Val_Pt3851
    elseif rtd_type === :Pt3911
        DAQmx_Val_Pt3911
    elseif rtd_type === :Pt3916
        DAQmx_Val_Pt3916
    elseif rtd_type === :Pt3920
        DAQmx_Val_Pt3920
    elseif rtd_type === :Pt3928
        DAQmx_Val_Pt3928
    elseif rtd_type === :Custom
        DAQmx_Val_Custom
    else
        throw(ArgumentError("Unknown rtd_type: $rtd_type"))
    end

    @check DAQmxCreateAIRTDChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        min_val,
        max_val,
        Int32(units_code),
        Int32(rtd_type_code),
        Int32(resistance_config),
        Int32(current_excit_source),
        current_excit_val,
        r0
    )

    return task
end

"""
    add_ai_resistance!(task::AITask, channel::String;
                       min_val::Float64=0.0,
                       max_val::Float64=1000.0,
                       units::Symbol=:Ohms,
                       resistance_config::ResistanceConfig=TwoWire,
                       current_excit_source::ExcitationSource=ExcitationInternal,
                       current_excit_val::Float64=0.001,
                       name::String="",
                       custom_scale::String="")

Add a resistance measurement channel.
"""
function add_ai_resistance!(task::AITask, channel::String;
                            min_val::Float64=0.0,
                            max_val::Float64=1000.0,
                            units::Symbol=:Ohms,
                            resistance_config::ResistanceConfig=TwoWire,
                            current_excit_source::ExcitationSource=ExcitationInternal,
                            current_excit_val::Float64=0.001,
                            name::String="",
                            custom_scale::String="")

    units_code = if units === :Ohms
        DAQmx_Val_Ohms
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    @check DAQmxCreateAIResistanceChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        min_val,
        max_val,
        Int32(units_code),
        Int32(resistance_config),
        Int32(current_excit_source),
        current_excit_val,
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ai_accel!(task::AITask, channel::String;
                  terminal_config::TerminalConfig=Differential,
                  min_val::Float64=-5.0,
                  max_val::Float64=5.0,
                  units::Symbol=:g,
                  sensitivity::Float64=100.0,
                  sensitivity_units::Symbol=:mVoltsPerG,
                  current_excit_source::ExcitationSource=ExcitationInternal,
                  current_excit_val::Float64=0.002,
                  name::String="",
                  custom_scale::String="")

Add an accelerometer input channel.

# Keyword Arguments
- `sensitivity::Float64`: Sensor sensitivity (default: 100.0 mV/g).
- `sensitivity_units::Symbol`: Units for sensitivity (`:mVoltsPerG`, `:VoltsPerG`).
"""
function add_ai_accel!(task::AITask, channel::String;
                       terminal_config::TerminalConfig=Differential,
                       min_val::Float64=-5.0,
                       max_val::Float64=5.0,
                       units::Symbol=:g,
                       sensitivity::Float64=100.0,
                       sensitivity_units::Symbol=:mVoltsPerG,
                       current_excit_source::ExcitationSource=ExcitationInternal,
                       current_excit_val::Float64=0.002,
                       name::String="",
                       custom_scale::String="")

    units_code = if units === :g
        DAQmx_Val_g
    elseif units === :MetersPerSecondSquared
        DAQmx_Val_MetersPerSecondSquared
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    sens_units_code = if sensitivity_units === :mVoltsPerG
        DAQmx_Val_mVoltsPerG
    elseif sensitivity_units === :VoltsPerG
        DAQmx_Val_VoltsPerG
    else
        throw(ArgumentError("Unknown sensitivity_units: $sensitivity_units"))
    end

    @check DAQmxCreateAIAccelChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        Int32(terminal_config),
        min_val,
        max_val,
        Int32(units_code),
        sensitivity,
        Int32(sens_units_code),
        Int32(current_excit_source),
        current_excit_val,
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

# ============================================================================
# Analog Output Channels
# ============================================================================

"""
    add_ao_voltage!(task::AOTask, channel::String;
                    min_val::Float64=-10.0,
                    max_val::Float64=10.0,
                    units::Symbol=:Volts,
                    name::String="",
                    custom_scale::String="")

Add an analog output voltage channel to the task.

# Arguments
- `task::AOTask`: The analog output task.
- `channel::String`: Physical channel name (e.g., "Dev1/ao0").

# Keyword Arguments
- `min_val::Float64`: Minimum output value in units (default: -10.0).
- `max_val::Float64`: Maximum output value in units (default: 10.0).
- `units::Symbol`: Units for output (default: `:Volts`).
- `name::String`: Name to assign to the channel.
- `custom_scale::String`: Name of custom scale if units is `:FromCustomScale`.

# Example
```julia
task = AOTask()
add_ao_voltage!(task, "Dev1/ao0"; min_val=0.0, max_val=5.0)
```
"""
function add_ao_voltage!(task::AOTask, channel::String;
                         min_val::Float64=-10.0,
                         max_val::Float64=10.0,
                         units::Symbol=:Volts,
                         name::String="",
                         custom_scale::String="")

    units_code = if units === :Volts
        DAQmx_Val_Volts
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units. Expected :Volts or :FromCustomScale"))
    end

    @check DAQmxCreateAOVoltageChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        min_val,
        max_val,
        Int32(units_code),
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ao_current!(task::AOTask, channel::String;
                    min_val::Float64=0.0,
                    max_val::Float64=0.02,
                    units::Symbol=:Amps,
                    name::String="",
                    custom_scale::String="")

Add an analog output current channel to the task.
"""
function add_ao_current!(task::AOTask, channel::String;
                         min_val::Float64=0.0,
                         max_val::Float64=0.02,
                         units::Symbol=:Amps,
                         name::String="",
                         custom_scale::String="")

    units_code = if units === :Amps
        DAQmx_Val_Amps
    elseif units === :FromCustomScale
        DAQmx_Val_FromCustomScale
    else
        throw(ArgumentError("Unknown units: $units"))
    end

    @check DAQmxCreateAOCurrentChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        min_val,
        max_val,
        Int32(units_code),
        isempty(custom_scale) ? NULLSTR : _cstr(custom_scale)
    )

    return task
end

"""
    add_ao_funcgen!(task::AOTask, channel::String;
                    type::Symbol=:Sine,
                    freq::Float64=1000.0,
                    amplitude::Float64=1.0,
                    offset::Float64=0.0,
                    name::String="")

Add a function generator channel to the task.

# Keyword Arguments
- `type::Symbol`: Waveform type (`:Sine`, `:Triangle`, `:Square`, `:Sawtooth`).
- `freq::Float64`: Frequency in Hz.
- `amplitude::Float64`: Peak-to-peak amplitude in volts.
- `offset::Float64`: DC offset in volts.
"""
function add_ao_funcgen!(task::AOTask, channel::String;
                         type::Symbol=:Sine,
                         freq::Float64=1000.0,
                         amplitude::Float64=1.0,
                         offset::Float64=0.0,
                         name::String="")

    type_code = if type === :Sine
        14751  # DAQmx_Val_Sine
    elseif type === :Triangle
        14752  # DAQmx_Val_Triangle
    elseif type === :Square
        14753  # DAQmx_Val_Square
    elseif type === :Sawtooth
        14754  # DAQmx_Val_Sawtooth
    else
        throw(ArgumentError("Unknown type: $type"))
    end

    @check DAQmxCreateAOFuncGenChan(
        task.handle,
        _cstr(channel),
        _cstr(name),
        Int32(type_code),
        freq,
        amplitude,
        offset
    )

    return task
end

# ============================================================================
# Convenience Constructors
# ============================================================================

"""
    AITask(channel::String; kwargs...) -> AITask

Create an analog input task with a single voltage channel.

# Example
```julia
task = AITask("Dev1/ai0"; terminal_config=RSE)
```
"""
function AITask(channel::String; kwargs...)
    task = AITask()
    add_ai_voltage!(task, channel; kwargs...)
    return task
end

"""
    AOTask(channel::String; kwargs...) -> AOTask

Create an analog output task with a single voltage channel.

# Example
```julia
task = AOTask("Dev1/ao0"; min_val=0.0, max_val=5.0)
```
"""
function AOTask(channel::String; kwargs...)
    task = AOTask()
    add_ao_voltage!(task, channel; kwargs...)
    return task
end
