cd $HOME

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# UMKC stuff
export lw='ndari@lewis4.rnet.missouri.edu'

# Java stuff
case "$machine" in
        Linux*) export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64;;
        Mac*)   export JAVA_HOME=$(/usr/libexec/java_home);;
esac

# Spark and Hive
export SPARK_HOME=$HOME/tools/spark-2.4.4-bin-hadoop2.7
export PYSPARK_PYTHON=$HOME/miniconda3/bin/python
export HIVE_HOME=$HOME/tools/apache-hive-3.1.1-bin

# ocaml stuff
# source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# eval $(opam config env)

#### Go stuff
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on

# racket stuff
#alias rak='racket -il xrepl'

# linux pbcopy/paste
if [ $machine = 'Linux' ]; then
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
fi

#alias guix=$HOME/.config/guix/current/bin/guix

# gerbil stuff
#export GERBIL_HOME=/usr/local/opt/gerbil-scheme/libexec

# path. just add to this

ALLPATHS=(
        "$HOME/miniconda3/bin"
        "$SPARK_HOME/bin"
        "$HIVE_HOME/bin"
        "$HOME/go/bin"
        "$GOROOT/bin"
        "$HOME/.cargo/bin"
        "$HOME/bin"
        "/usr/local/bin"
        "$HOME/.local/bin"
        "$HOME/.nimble/bin"
)
printf -v NEWPATHS "%s:" "${ALLPATHS[@]}"
export PATH=${NEWPATHS}${PATH}
# export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale

# Rust stuff
# for racer to work. Must get rust source with "rustup component add rust-src"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# olcao stuff
if [ $machine = 'Linux' ]; then
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/lib:$HOME/include:/usr/lib
fi
