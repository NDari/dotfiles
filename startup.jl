# set a local directory for personal code, and add it to the
# load path so that we can easily use the modules.
#= push!(LOAD_PATH,"$(homedir())/Projects/Julia" ) =#

#= using Pkg =#
#= if isfile("Project.toml") =#
#=     # auto-activate project in current directory =#
#=     @info "Activating project in $(pwd())" =#
#=     Pkg.activate(".") =#
#= end =#

#= @info "Importing Revise" =#
#= try =#
#=     #1= haskey(Pkg.installed(), "Revise") || @eval Pkg.add("Revise") =1# =#
#=     using Revise =#
#=     # configure Revise to run revise() before every REPL eval =#
#=     Revise.async_steal_repl_backend() =#
#= catch ex =#
#=     @warn "Could not load Revise: $ex" =#
#= end =#

@info "Importing OhMyREPL"
using OhMyREPL
colorscheme!("Monokai24bit")
OhMyREPL.enable_autocomplete_brackets(false)
#= catch ex =#
#=     @warn "Could not load OhMyREPL: $ex" =#
#= end =#

#= @info "Importing Debugger" =#
#= try =#
#=     #1= haskey(Pkg.installed(), "Debugger") || @eval Pkg.add("Debugger") =1# =#
#=     using Debugger =#
#= catch ex =#
#=     @warn "Could not load OhMyREPL: $ex" =#
#= end =#
