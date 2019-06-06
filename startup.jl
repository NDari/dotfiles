# in each project, we can include a _init.jl file to load the
# module etc. When starting julia from that directory, it
# will automatically run the initialization for us.
isfile("_init.jl") && include(joinpath(pwd(), "_init.jl"))

# set a local directory for personal code, and add it to the
# load path so that we can easily use the modules.
push!(LOAD_PATH,"$(homedir())/Projects/Julia" )

# use revise. Automatically loads git, module, etc changes
# when using the repl.
atreplinit() do repl
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
        @warn "Could not load Revise."
    end

    try
        @eval using Rebugger
    catch
        @warn "Could not load Rebugger."
    end
end

