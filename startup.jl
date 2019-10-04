# in each project, we can include a _init.jl file to load the
# module etc. When starting julia from that directory, it
# will automatically run the initialization for us.
isfile("_init.jl") && include(joinpath(pwd(), "_init.jl"))

# use revise. Automatically loads git, module, etc changes
# when using the repl.
atreplinit() do repl
    try
        @eval using Debugger
    catch
        @warn "Could not load Debugger."
    end

    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
        @warn "Could not load Revise."
    end
end

using OhMyREPL
OhMyREPL.enable_autocomplete_brackets(false)
