# UMKC stuff
export lw='ndari@lewis4.rnet.missouri.edu'

# python
export PATH=$HOME/miniconda3/bin:$PATH

# Java stuff
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Spark and Hive
export SPARK_HOME=$HOME/tools/spark-2.4.0-bin-hadoop2.7
export PYSPARK_PYTHON=$HOME/miniconda3/bin/python
export HIVE_HOME=$HOME/tools/apache-hive-3.1.1-bin
export PATH=$SPARK_HOME/bin:$HIVE_HOME/bin:$PATH

# ocaml stuff
# source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# eval $(opam config env)

#### Go stuff
# export GOROOT=/usr/local/go
export PATH=$HOME/go/bin:$PATH
# export GOPATH=$HOME/go
# export GOBIN=$GOPATH/bin
# export PATH=$GOBIN:$GOROOT/bin:$PATH
export GOROOT=/usr/local/go
export PATH=$HOME/go/bin:$GOROOT/bin:$PATH

# Rust stuff
export PATH="$HOME/.cargo/bin:$PATH"
# for racer to work. Must get rust source with "rustup component add rust-src"
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src

# racket stuff
alias rak='racket -il xrepl'

# linux pbcopy/paste
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias gforth=$HOME/tools/gforth/gforth
alias guix=$HOME/.config/guix/current/bin/guix

# gerbil stuff
export PATH=/usr/local/opt/gambit-scheme/current/bin:$PATH
export GERBIL_HOME=/usr/local/opt/gerbil-scheme/libexec
