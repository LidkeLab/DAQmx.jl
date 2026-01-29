# Type-safe property system for NIDAQmx.jl

# ============================================================================
# Property Metadata Definition
# ============================================================================

"""
    PropertyDef

Defines metadata for a NIDAQmx property including getter/setter functions and type.
"""
struct PropertyDef
    getter::Symbol
    setter::Union{Symbol, Nothing}
    value_type::Type
    description::String
end

PropertyDef(getter::Symbol, setter::Symbol, value_type::Type) =
    PropertyDef(getter, setter, value_type, "")
PropertyDef(getter::Symbol, ::Nothing, value_type::Type) =
    PropertyDef(getter, nothing, value_type, "")

is_settable(p::PropertyDef) = p.setter !== nothing

# ============================================================================
# Property Metadata Dictionary
# ============================================================================

"""
    CHANNEL_PROPERTIES

Dictionary mapping property symbols to their metadata for channel properties.
"""
const CHANNEL_PROPERTIES = Dict{Symbol, PropertyDef}(
    # AI Properties
    :ai_max => PropertyDef(:DAQmxGetAIMax, :DAQmxSetAIMax, Float64, "Maximum value to measure"),
    :ai_min => PropertyDef(:DAQmxGetAIMin, :DAQmxSetAIMin, Float64, "Minimum value to measure"),
    :ai_terminal_config => PropertyDef(:DAQmxGetAITermCfg, :DAQmxSetAITermCfg, Int32, "Terminal configuration"),
    :ai_resolution => PropertyDef(:DAQmxGetAIResolution, nothing, Float64, "Resolution in bits"),
    :ai_gain => PropertyDef(:DAQmxGetAIGain, :DAQmxSetAIGain, Float64, "Gain"),
    :ai_meas_type => PropertyDef(:DAQmxGetAIMeasType, nothing, Int32, "Measurement type"),

    # AO Properties
    :ao_max => PropertyDef(:DAQmxGetAOMax, :DAQmxSetAOMax, Float64, "Maximum output value"),
    :ao_min => PropertyDef(:DAQmxGetAOMin, :DAQmxSetAOMin, Float64, "Minimum output value"),
    :ao_output_type => PropertyDef(:DAQmxGetAOOutputType, nothing, Int32, "Output type"),

    # CI Properties
    :ci_meas_type => PropertyDef(:DAQmxGetCIMeasType, nothing, Int32, "Measurement type"),

    # CO Properties
    :co_output_type => PropertyDef(:DAQmxGetCOOutputType, nothing, Int32, "Output type"),
)

"""
    TASK_PROPERTIES

Dictionary mapping property symbols to their metadata for task properties.
"""
const TASK_PROPERTIES = Dict{Symbol, PropertyDef}(
    :num_channels => PropertyDef(:DAQmxGetTaskNumChans, nothing, UInt32, "Number of channels"),
    :sample_rate => PropertyDef(:DAQmxGetSampClkRate, :DAQmxSetSampClkRate, Float64, "Sample clock rate"),
    :samples_per_channel => PropertyDef(:DAQmxGetSampQuantSampPerChan, :DAQmxSetSampQuantSampPerChan, UInt64, "Samples per channel"),
)

# ============================================================================
# Channel Type Detection
# ============================================================================

"""
    channel_type(task::Task, channel::String) -> Symbol

Get the type of a channel (:AI, :AO, :DI, :DO, :CI, :CO).
"""
function channel_type(task::Task, channel::String)
    val = Ref{Int32}(0)
    @check DAQmxGetChanType(task.handle, _cstr(channel), val)

    chan_type = val[]
    if chan_type == DAQmx_Val_AI
        return :AI
    elseif chan_type == DAQmx_Val_AO
        return :AO
    elseif chan_type == DAQmx_Val_DI
        return :DI
    elseif chan_type == DAQmx_Val_DO
        return :DO
    elseif chan_type == DAQmx_Val_CI
        return :CI
    elseif chan_type == DAQmx_Val_CO
        return :CO
    else
        return :Unknown
    end
end

"""
    measurement_type(task::Task, channel::String) -> Int32

Get the measurement or output type for a channel.
Returns the NIDAQmx constant value.
"""
function measurement_type(task::Task, channel::String)
    ctype = channel_type(task, channel)
    val = Ref{Int32}(0)

    if ctype === :AI
        @check DAQmxGetAIMeasType(task.handle, _cstr(channel), val)
    elseif ctype === :AO
        @check DAQmxGetAOOutputType(task.handle, _cstr(channel), val)
    elseif ctype === :CI
        @check DAQmxGetCIMeasType(task.handle, _cstr(channel), val)
    elseif ctype === :CO
        @check DAQmxGetCOOutputType(task.handle, _cstr(channel), val)
    else
        return Int32(0)
    end

    return val[]
end

# ============================================================================
# Property Access Functions
# ============================================================================

"""
    get_channel_property(task::Task, channel::String, property::Symbol)

Get a property value for a specific channel.

# Example
```julia
task = AITask("Dev1/ai0")
max_val = get_channel_property(task, "Dev1/ai0", :ai_max)
```
"""
function get_channel_property(task::Task, channel::String, property::Symbol)
    if !haskey(CHANNEL_PROPERTIES, property)
        throw(ArgumentError("Unknown channel property: $property"))
    end

    prop_def = CHANNEL_PROPERTIES[property]
    getter = getfield(NIDAQmx, prop_def.getter)

    val = Ref{prop_def.value_type}(zero(prop_def.value_type))
    @check getter(task.handle, _cstr(channel), val)
    return val[]
end

"""
    set_channel_property!(task::Task, channel::String, property::Symbol, value)

Set a property value for a specific channel.

# Example
```julia
task = AITask("Dev1/ai0")
set_channel_property!(task, "Dev1/ai0", :ai_max, 5.0)
```
"""
function set_channel_property!(task::Task, channel::String, property::Symbol, value)
    if !haskey(CHANNEL_PROPERTIES, property)
        throw(ArgumentError("Unknown channel property: $property"))
    end

    prop_def = CHANNEL_PROPERTIES[property]

    if prop_def.setter === nothing
        throw(ArgumentError("Property $property is read-only"))
    end

    setter = getfield(NIDAQmx, prop_def.setter)
    @check setter(task.handle, _cstr(channel), convert(prop_def.value_type, value))
    return nothing
end

"""
    get_task_property(task::Task, property::Symbol)

Get a property value for a task.
"""
function get_task_property(task::Task, property::Symbol)
    if !haskey(TASK_PROPERTIES, property)
        throw(ArgumentError("Unknown task property: $property"))
    end

    prop_def = TASK_PROPERTIES[property]
    getter = getfield(NIDAQmx, prop_def.getter)

    val = Ref{prop_def.value_type}(zero(prop_def.value_type))
    @check getter(task.handle, val)
    return val[]
end

"""
    set_task_property!(task::Task, property::Symbol, value)

Set a property value for a task.
"""
function set_task_property!(task::Task, property::Symbol, value)
    if !haskey(TASK_PROPERTIES, property)
        throw(ArgumentError("Unknown task property: $property"))
    end

    prop_def = TASK_PROPERTIES[property]

    if prop_def.setter === nothing
        throw(ArgumentError("Property $property is read-only"))
    end

    setter = getfield(NIDAQmx, prop_def.setter)
    @check setter(task.handle, convert(prop_def.value_type, value))
    return nothing
end

# ============================================================================
# Property Enumeration
# ============================================================================

"""
    list_channel_properties() -> Vector{Symbol}

List all available channel properties.
"""
list_channel_properties() = collect(keys(CHANNEL_PROPERTIES))

"""
    list_task_properties() -> Vector{Symbol}

List all available task properties.
"""
list_task_properties() = collect(keys(TASK_PROPERTIES))

"""
    property_info(property::Symbol) -> PropertyDef

Get information about a property.
"""
function property_info(property::Symbol)
    if haskey(CHANNEL_PROPERTIES, property)
        return CHANNEL_PROPERTIES[property]
    elseif haskey(TASK_PROPERTIES, property)
        return TASK_PROPERTIES[property]
    else
        throw(ArgumentError("Unknown property: $property"))
    end
end

# ============================================================================
# Convenience Functions
# ============================================================================

"""
    get_all_channel_properties(task::Task, channel::String) -> Dict{Symbol, Any}

Get all readable properties for a channel.
"""
function get_all_channel_properties(task::Task, channel::String)
    ctype = channel_type(task, channel)
    properties = Dict{Symbol, Any}()

    # Filter properties by channel type
    prefix = if ctype === :AI
        "ai_"
    elseif ctype === :AO
        "ao_"
    elseif ctype === :CI
        "ci_"
    elseif ctype === :CO
        "co_"
    else
        return properties
    end

    for (name, prop_def) in CHANNEL_PROPERTIES
        if startswith(string(name), prefix)
            try
                properties[name] = get_channel_property(task, channel, name)
            catch
                # Property not supported for this specific channel configuration
            end
        end
    end

    return properties
end

# ============================================================================
# Base.getproperty / Base.setproperty! Overloads (Optional)
# ============================================================================

# Note: These are intentionally not implemented to avoid confusion with
# Task struct fields. Use the explicit get_channel_property/set_channel_property!
# functions instead.

# If desired, one could implement property access on a channel wrapper:
#
# struct ChannelRef
#     task::Task
#     name::String
# end
#
# function Base.getproperty(c::ChannelRef, prop::Symbol)
#     if prop in (:task, :name)
#         return getfield(c, prop)
#     else
#         return get_channel_property(c.task, c.name, prop)
#     end
# end
