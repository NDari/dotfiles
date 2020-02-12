# in each project, we can include a _init.jl file to load the
# module etc. When starting julia from that directory, it
# will automatically run the initialization for us.
isfile("_init.jl") && include(joinpath(pwd(), "_init.jl"))

# set a local directory for personal code, and add it to the
# load path so that we can easily use the modules.
#= push!(LOAD_PATH,"$(homedir())/Projects/Julia" ) =#

using Pkg
if isfile("Project.toml")
    # auto-activate project in current directory
    @info "Activating project in $(pwd())"
    Pkg.activate(".")
end

@info "Importing Revise"
try
    haskey(Pkg.installed(), "Revise") || @eval Pkg.add("Revise")
    using Revise
    # configure Revise to run revise() before every REPL eval
    Revise.async_steal_repl_backend()
catch ex
    @warn "Could not load Revise: $ex"
end

@info "Importing OhMyREPL"
try
    haskey(Pkg.installed(), "OhMyREPL") || @eval Pkg.add("OhMyREPL")
    using OhMyREPL
    colorscheme!("Monokai24bit")
    OhMyREPL.enable_autocomplete_brackets(false)
catch ex
    @warn "Could not load OhMyREPL: $ex"
end

@info "Importing Debugger"
try
    haskey(Pkg.installed(), "Debugger") || @eval Pkg.add("Debugger")
    using Debugger
catch ex
    @warn "Could not load OhMyREPL: $ex"
end
