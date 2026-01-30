# Digital channel functions for DAQmx.jl

"""
    add_di_chan!(task::DITask, lines::String;
                 line_grouping::LineGrouping=ChannelPerLine,
                 name::String="")

Add digital input lines to the task.

# Arguments
- `task::DITask`: The digital input task.
- `lines::String`: Physical lines (e.g., "Dev1/port0/line0:7" or "Dev1/port0").

# Keyword Arguments
- `line_grouping::LineGrouping`: How to group lines (default: `ChannelPerLine`).
  - `ChannelPerLine`: Create one channel for each line.
  - `ChannelForAllLines`: Create one channel for all lines.
- `name::String`: Name to assign to the channel(s).

# Example
```julia
task = DITask()
add_di_chan!(task, "Dev1/port0/line0:7")
start!(task)
data = read(task)
```
"""
function add_di_chan!(task::DITask, lines::String;
                      line_grouping::LineGrouping=ChannelPerLine,
                      name::String="")

    @check DAQmxCreateDIChan(
        task.handle,
        _cstr(lines),
        _cstr(name),
        Int32(line_grouping)
    )

    return task
end

"""
    add_do_chan!(task::DOTask, lines::String;
                 line_grouping::LineGrouping=ChannelPerLine,
                 name::String="")

Add digital output lines to the task.

# Arguments
- `task::DOTask`: The digital output task.
- `lines::String`: Physical lines (e.g., "Dev1/port0/line0:7" or "Dev1/port0").

# Keyword Arguments
- `line_grouping::LineGrouping`: How to group lines (default: `ChannelPerLine`).
  - `ChannelPerLine`: Create one channel for each line.
  - `ChannelForAllLines`: Create one channel for all lines.
- `name::String`: Name to assign to the channel(s).

# Example
```julia
task = DOTask()
add_do_chan!(task, "Dev1/port0/line0:7")
write(task, UInt8[0xFF])
```
"""
function add_do_chan!(task::DOTask, lines::String;
                      line_grouping::LineGrouping=ChannelPerLine,
                      name::String="")

    @check DAQmxCreateDOChan(
        task.handle,
        _cstr(lines),
        _cstr(name),
        Int32(line_grouping)
    )

    return task
end

# ============================================================================
# Convenience Constructors
# ============================================================================

"""
    DITask(lines::String; kwargs...) -> DITask

Create a digital input task with the specified lines.

# Example
```julia
task = DITask("Dev1/port0/line0:7")
```
"""
function DITask(lines::String; kwargs...)
    task = DITask()
    add_di_chan!(task, lines; kwargs...)
    return task
end

"""
    DOTask(lines::String; kwargs...) -> DOTask

Create a digital output task with the specified lines.

# Example
```julia
task = DOTask("Dev1/port0/line0:7")
```
"""
function DOTask(lines::String; kwargs...)
    task = DOTask()
    add_do_chan!(task, lines; kwargs...)
    return task
end
