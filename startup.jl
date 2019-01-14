using OhMyREPL
using Revise
#= atreplinit() do repl =#
#=     try =#
#=         @eval using Revise =#
#=         @async Revise.wait_steal_repl_backend() =#
#=     catch =#
#=     end =#
#= end =#

# always develop in $HOME/Projects/Julia
function devDir()
    devDir::String =  "$(homedir())/Projects/Julia"
end

push!(LOAD_PATH,devDir())
cd(devDir())
