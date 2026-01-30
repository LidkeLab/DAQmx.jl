using DAQmx
using Documenter

DocMeta.setdocmeta!(DAQmx, :DocTestSetup, :(using DAQmx); recursive=true)

makedocs(;
    modules=[DAQmx],
    authors="klidke@unm.edu",
    sitename="DAQmx.jl",
    format=Documenter.HTML(;
        canonical="https://LidkeLab.github.io/DAQmx.jl",
        edit_link="main",
        assets=String[],
        prettyurls=get(ENV, "CI", "false") == "true",
    ),
    pages=[
        "Home" => "index.md",
        "Examples" => "examples.md",
        "API" => "api.md",
    ],
    warnonly=[:missing_docs, :cross_references],
)

deploydocs(;
    repo="github.com/LidkeLab/DAQmx.jl",
    devbranch="main",
)
