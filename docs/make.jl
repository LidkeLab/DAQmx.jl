using NIDAQmx
using Documenter

DocMeta.setdocmeta!(NIDAQmx, :DocTestSetup, :(using NIDAQmx); recursive=true)

makedocs(;
    modules=[NIDAQmx],
    authors="klidke@unm.edu",
    sitename="NIDAQmx.jl",
    format=Documenter.HTML(;
        canonical="https://LidkeLab.github.io/NIDAQmx.jl",
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
    repo="github.com/LidkeLab/NIDAQmx.jl",
    devbranch="main",
)
