# NIDAQmx binding generator using Clang.jl
#
# This script generates Julia bindings from the NIDAQmx C header file.
# The generated bindings are committed to the repository and are not
# regenerated at build time.
#
# Usage:
#   1. Ensure Clang.jl is installed in this project
#   2. Update generator.toml with paths for your system
#   3. Run: julia --project=. generator.jl
#
# Requirements:
#   - NIDAQmx header file (NIDAQmx.h)
#   - Clang.jl v0.16+

using Clang.Generators
using Clang.LibClang.Clang_jll

cd(@__DIR__)

# Load configuration
options = load_options(joinpath(@__DIR__, "generator.toml"))

# Get include directories for NIDAQmx
# On Windows, this is typically in the NI installation directory
include_dir = if Sys.iswindows()
    # Default NI-DAQmx installation path
    raw"C:\Program Files (x86)\National Instruments\NI-DAQ\DAQmx ANSI C Dev\include"
else
    "/usr/local/natinst/nidaqmx/include"
end

# Add compiler flags
args = get_default_args()
push!(args, "-I$include_dir")

# On Windows, add additional defines
if Sys.iswindows()
    push!(args, "-D_WIN32")
    push!(args, "-D_CRT_SECURE_NO_WARNINGS")
end

# Header file to process
headers = [joinpath(include_dir, "NIDAQmx.h")]

# Check if header exists
if !isfile(headers[1])
    @error "NIDAQmx.h not found at $(headers[1])"
    @info "Please update the include_dir path in this script or generator.toml"
    exit(1)
end

@info "Processing headers" headers

# Create context
ctx = create_context(headers, args, options)

# Run generator
build!(ctx)

@info "Generation complete. Output written to $(options["general"]["output_file_path"])"

# Post-processing: Apply any necessary fixups to the generated code
function postprocess_generated_code(output_path::String)
    if !isfile(output_path)
        @warn "Output file not found, skipping post-processing"
        return
    end

    content = read(output_path, String)

    # Replace library path placeholder
    content = replace(content, "LIBRARY_PATH" => "libnidaq")

    # Remove or comment out problematic definitions
    # (specific fixups would go here based on Clang.jl output)

    write(output_path, content)
    @info "Post-processing complete"
end

# Run post-processing if enabled
if get(options, "general", Dict())["run_postprocessing"] === true
    postprocess_generated_code(options["general"]["output_file_path"])
end
