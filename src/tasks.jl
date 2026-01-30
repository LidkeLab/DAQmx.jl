# Task lifecycle management for DAQmx.jl

"""
    start!(task::Task)

Start the specified task. The task begins performing its configured operations.

# Arguments
- `task::Task`: The task to start.

# Throws
- `NIDAQError`: If the task cannot be started.

# Example
```julia
task = AITask("Dev1/ai0")
configure_timing!(task; rate=1000.0, samples_per_channel=100)
start!(task)
data = read(task)
stop!(task)
```
"""
function start!(task::Task)
    @check DAQmxStartTask(task.handle)
    return nothing
end

"""
    stop!(task::Task)

Stop the specified task. The task stops performing its operations but remains configured.

# Arguments
- `task::Task`: The task to stop.

# Throws
- `NIDAQError`: If the task cannot be stopped.
"""
function stop!(task::Task)
    @check DAQmxStopTask(task.handle)
    return nothing
end

"""
    clear!(task::Task)

Clear the specified task, releasing all resources associated with it.
After clearing, the task handle is no longer valid.

# Arguments
- `task::Task`: The task to clear.

# Note
This is typically called automatically by the finalizer, but can be called
explicitly if you want to release resources immediately.
"""
function clear!(task::Task)
    if task.handle != C_NULL
        @check DAQmxClearTask(task.handle)
        task.handle = C_NULL
    end
    return nothing
end

"""
    wait_until_done(task::Task; timeout::Float64=-1.0)

Wait until the task has completed all operations.

# Arguments
- `task::Task`: The task to wait on.
- `timeout::Float64`: Maximum time to wait in seconds. Use -1.0 to wait indefinitely.

# Throws
- `NIDAQError`: If the wait times out or encounters an error.

# Example
```julia
task = AOTask("Dev1/ao0")
configure_timing!(task; rate=1000.0, samples_per_channel=100)
write(task, data)
start!(task)
wait_until_done(task)
stop!(task)
```
"""
function wait_until_done(task::Task; timeout::Float64=-1.0)
    @check DAQmxWaitUntilTaskDone(task.handle, timeout)
    return nothing
end

"""
    is_done(task::Task) -> Bool

Check if the task has completed all operations.

# Arguments
- `task::Task`: The task to check.

# Returns
- `true` if the task is done, `false` otherwise.
"""
function is_done(task::Task)
    done_ref = Ref{Bool32}(0)
    @check DAQmxIsTaskDone(task.handle, Base.unsafe_convert(Ptr{Bool32}, done_ref))
    return Bool(done_ref[])
end

"""
    control!(task::Task, action::Symbol)

Perform a control action on the task.

# Arguments
- `task::Task`: The task to control.
- `action::Symbol`: The action to perform. One of:
  - `:start`: Start the task
  - `:stop`: Stop the task
  - `:verify`: Verify the task configuration
  - `:commit`: Commit the task (transition to committed state)
  - `:reserve`: Reserve task resources
  - `:unreserve`: Unreserve task resources
  - `:abort`: Abort the task

# Throws
- `NIDAQError`: If the action fails.
- `ArgumentError`: If the action is not recognized.
"""
function control!(task::Task, action::Symbol)
    action_code = if action === :start
        DAQmx_Val_Task_Start
    elseif action === :stop
        DAQmx_Val_Task_Stop
    elseif action === :verify
        DAQmx_Val_Task_Verify
    elseif action === :commit
        DAQmx_Val_Task_Commit
    elseif action === :reserve
        DAQmx_Val_Task_Reserve
    elseif action === :unreserve
        DAQmx_Val_Task_Unreserve
    elseif action === :abort
        DAQmx_Val_Task_Abort
    else
        throw(ArgumentError("Unknown action: $action. Expected one of: :start, :stop, :verify, :commit, :reserve, :unreserve, :abort"))
    end

    @check DAQmxTaskControl(task.handle, Int32(action_code))
    return nothing
end

"""
    num_channels(task::Task) -> Int

Get the number of channels in the task.

# Arguments
- `task::Task`: The task to query.

# Returns
- The number of channels in the task.
"""
function num_channels(task::Task)
    num_ref = Ref{UInt32}(0)
    @check DAQmxGetTaskNumChans(task.handle, Base.unsafe_convert(Ptr{UInt32}, num_ref))
    return Int(num_ref[])
end

"""
    task_name(task::Task) -> String

Get the name of the task.
"""
function task_name(task::Task)
    # First call to get buffer size
    sz = DAQmxGetTaskName(task.handle, NULLSTR, UInt32(0))
    sz <= 0 && return ""

    buffer = Vector{Int8}(undef, sz)
    @check DAQmxGetTaskName(task.handle, pointer(buffer), UInt32(sz))
    return unsafe_string(Ptr{UInt8}(pointer(buffer)))
end

"""
    channel_names(task::Task) -> Vector{String}

Get the names of all channels in the task.

# Returns
- A vector of channel names.
"""
function channel_names(task::Task)
    # First call to get buffer size
    sz = DAQmxGetTaskChannels(task.handle, NULLSTR, UInt32(0))
    sz <= 0 && return String[]

    buffer = Vector{Int8}(undef, sz)
    @check DAQmxGetTaskChannels(task.handle, pointer(buffer), UInt32(sz))

    channels_str = unsafe_string(Ptr{UInt8}(pointer(buffer)))
    isempty(channels_str) && return String[]

    return String.(strip.(split(channels_str, ",")))
end

"""
    device_names(task::Task) -> Vector{String}

Get the names of all devices used by the task.

# Returns
- A vector of device names.
"""
function device_names(task::Task)
    # First call to get buffer size
    sz = DAQmxGetTaskDevices(task.handle, NULLSTR, UInt32(0))
    sz <= 0 && return String[]

    buffer = Vector{Int8}(undef, sz)
    @check DAQmxGetTaskDevices(task.handle, pointer(buffer), UInt32(sz))

    devices_str = unsafe_string(Ptr{UInt8}(pointer(buffer)))
    isempty(devices_str) && return String[]

    return String.(strip.(split(devices_str, ",")))
end

# Export the start function for compatibility
# (In Julia 0.7+, start is not automatically exported from Base)
export start!
