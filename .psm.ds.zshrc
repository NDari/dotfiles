# pinsight stuff
export PATH=/Users/ndari/miniconda2/bin:$PATH
export ds5="datascience05.pc01.cls04"
export ds6="datascience06.pc01.cls04"
export ds7="datascience07.pc01.cls04"
export ds8="datascience08.pc01.cls04"
export SPARK_HOME=$HOME/tools/spark-2.2.0-bin-without-hadoop
export SPARK_DIST_CLASSPATH=$(hadoop classpath)
export HADOOP_CONF_DIR=/usr/hdp/2.6.1.0-129/hadoop/etc/hadoop/
export PATH=$SPARK_HOME:$SPARK_HOME/bin:$PATH
export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
