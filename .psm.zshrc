# pinsight stuff
export PATH="$HOME/miniconda3/bin":"$PATH"
export ds5="10.128.23.115"
export ds6="10.128.23.120"
export ds7="10.128.23.129"
export ds8="10.128.23.130"
export cl4="10.128.21.200"
export SPARK_HOME=$HOME/tools/spark-2.3.0
# export HADOOP_CONF_DIR=/usr/hdp/2.6.1.0-129/hadoop/etc/hadoop/
# export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH
# export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
export PATH=$SPARK_HOME:$SPARK_HOME/bin:$PATH
export PYSPARK_DRIVER_PYTHON=ipython
export JAVA_HOME=$(/usr/libexec/java_home)
alias goec2="ssh -i ~/AWS-datascience-EMR.pem ec2-user@10.130.23.236"


