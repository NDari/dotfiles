# UMKC stuff
export lw='ndari@lewis4.rnet.missouri.edu'

# python
export PATH=$HOME/miniconda3/bin:$PATH

# ocaml stuff
# source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# eval $(opam config env)

#### Go stuff
# export GOROOT=/usr/local/go
export PATH=$HOME/go/bin:$PATH
# export GOPATH=$HOME/go
# export GOBIN=$GOPATH/bin
# export PATH=$GOBIN:$GOROOT/bin:$PATH

# Rust stuff
export PATH="$HOME/.cargo/bin:$PATH"
# for racer to work. Must get rust source with "rustup component add rust-src"
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src

# cuda and cudann stuff
#export CUDA_HOME="/usr/local/cuda"
#export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
#export PATH="$CUDA_HOME/bin:$PATH"

# racket stuff
alias rak='racket -il xrepl'

# gerbil stuff
export PATH=/usr/local/opt/gambit-scheme/current/bin:$PATH
export GERBIL_HOME=/usr/local/opt/gerbil-scheme/libexec

# Java stuff
export JAVA_HOME=$(/usr/libexec/java_home)
