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
import Pkg

if isfile("Project.toml")
  # auto-activate project in current directory =#
  @info "Activating project in $(pwd())"
  Pkg.activate(".")
else
  want_packages = Set([
    "Debugger",
    "OhMyREPL",
    "DataFrames",
    "DataFramesMeta",
    "Revise",
  ])

  function top_level_deps()
    deps = Pkg.dependencies()
    installs = []
    for (uuid, dep) in deps
        dep.is_direct_dep || continue
        dep.version === nothing && continue
        push!(installs, dep.name)
    end
    return Set(installs)
  end

  uninstalled_packages = setdiff(want_packages, top_level_deps())

  for p in uninstalled_packages
    @info "Installing $p"
    Pkg.add(p)
  end

  @info "Importing OhMyREPL"
  using OhMyREPL
  colorscheme!("OneDark")
  OhMyREPL.enable_autocomplete_brackets(false)
end
