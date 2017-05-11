#!/usr/bin/env bash

sudo apt update
sudo apt -y upgrade

# General
############################################################################
sudo apt --yes install \
    autoconf \
    automake \
    cmake \
    gcc \
    libgeos-dev \
    openjdk-8-jdk \
    libtool \
    make \
    maven \
    ninja-build \
    pkgconf \
    unzip

mkdir -p $HOME/.local/bin
############################################################################


# Python3 setup
############################################################################
cd $HOME

mc_script=Miniconda3-4.5.11-Linux-x86_64.sh
pybin=$HOME/miniconda3/bin

wget "https://repo.continuum.io/miniconda/$mc_script"
chmod +x $mc_script
bash ./$mc_script -b -p $HOME/miniconda3

echo '' >> $HOME/.bash_profile
echo "export PATH=$pybin:$PATH" >> $HOME/.bash_profile
echo "export PYSPARK_PYTHON=$pybin/python" >> $HOME/.bash_profile
echo "alias pyspark='PYSPARK_DRIVER_PYTHON=ipython pyspark'" >> ${HOME}/.bash_profile
. $HOME/.bash_profile

$pybin/pip install --upgrade pip

$pybin/pip install \
    h3==3.1.0 \
    folium==0.8.3 \
    tldextract==2.2.1 \
    ipython==7.3.0 \
    jupyter==1.0.0 \
    jupyterlab==0.35.4 \
    matplotlib==3.0.3 \
    numpy==1.16.2 \
    pandas==0.24.1 \
    pyarrow==0.13.0 \
    pyspark==2.4.0 \
    scikit-learn==0.20.2 \
    shapely==1.6.4
############################################################################

##### spark
############################################################################
SPARK_VERSION="2.4.0"
HADOOP_VERSION="2.7"
SPARK_TAR_DIR="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"

mkdir -p $HOME/tools
cd $HOME/tools
wget http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/$SPARK_TAR_DIR
mkdir spark && tar zxvf $SPARK_TAR_DIR -C spark --strip-components 1
echo '' >> $HOME/.bash_profile
echo 'export SPARK_HOME=$HOME/tools/spark' >> $HOME/.bash_profile
echo 'export PATH=$SPARK_HOME/bin:$PATH' >> $HOME/.bash_profile

cd $HOME
. $HOME/.bash_profile
