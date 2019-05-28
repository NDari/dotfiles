# pinsight stuff
export ds5="10.128.23.115"
export ds6="10.128.23.120"
export ds7="10.128.23.129"
export ds8="10.128.23.130"
export cl4="10.128.21.200"
export SPARK_HOME=$HOME/tools/spark-2.4.0-bin-hadoop2.7
# export HADOOP_CONF_DIR=/usr/hdp/2.6.1.0-129/hadoop/etc/hadoop/
# export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH
# export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
export PATH=$SPARK_HOME/bin:$PATH
export PYSPARK_DRIVER_PYTHON=ipython
export JAVA_HOME=$(/usr/libexec/java_home)

alias dmserver='ndari@10.133.3.99'

# Rust stuff
export PATH="$HOME/.cargo/bin:$PATH"
# for racer to work. Must get rust source with "rustup component add rust-src"
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
