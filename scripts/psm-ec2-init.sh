#!/usr/bin/env sh

sudo yum -y update
sudo yum -y install \
    autoconf \
    automake \
    cmake \
    ctags \
    gcc \
    gcc-c++ \
    geos-devel \
    git \
    java-1.8.0-openjdk-devel.x86_64 \
    libtool \
    make \
    ninja-build \
    patch \
    pkgconfig \
    tmux \
    unzip \
    util-linux-user.x86_64 \
    zsh

mkdir -p $HOME/.local/bin

# Python3 setup
############################################################################
cd $HOME

mc_script=Miniconda3-4.5.11-Linux-x86_64.sh
pybin=$HOME/miniconda3/bin/

wget "https://repo.continuum.io/miniconda/$mc_script"
chmod +x $mc_script
bash ./$mc_script -b -p $HOME/miniconda3

echo '' >> $HOME/.bash_profile
echo 'export PATH=$pybin:$PATH' >> $HOME/.bash_profile
echo "export PYSPARK_PYTHON=$pybin/python" >> $HOME/.bash_profile
echo "alias pyspark='PYSPARK_DRIVER_PYTHON=ipython pyspark'" >> ${HOME}/.bash_profile
source $HOME/.bash_profile

$pybin/pip install --upgrade pip

$pybin/pip install \
    awscli \
    beautifulsoup4 \
    bokeh \
    boto3 \
    cython \
    dask \
    datashader \
    fastdtw \
    findspark \
    folium \
    geopandas \
    hdfs3 \
    ipython \
    jupyter \
    jupyterlab \
    knit \
    matplotlib \
    nodejs \
    numba \
    pandas \
    plotly \
    polyline \
    pyarrow \
    pyproj \
    pyshp \
    requests \
    rtree \
    s3fs \
    scikit-learn \
    shapely \
    ujson
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

MAVEN_VERSION=3.6.2
HADOOP_AWS_VERSION=2.7.3
JARS_DIR=$HOME/tools/spark/jars/

# Maven, and the needed jars to read from s3
wget http://apache.mirrors.ionfish.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
tar zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz
$HOME/tools/apache-maven-$MAVEN_VERSION/bin/mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-aws:$HADOOP_AWS_VERSION
cp $HOME/.m2/repository/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar $JARS_DIR
cp $HOME/.m2/repository/org/apache/hadoop/hadoop-aws/$HADOOP_AWS_VERSION/hadoop-aws-$HADOOP_AWS_VERSION.jar $JARS_DIR
cd $HOME
source $HOME/.bash_profile

##### ZSH and Neovim set up
############################################################################
NVIM_VERSION="0.3.4"
$pybin/pip install pynvim sexpdata websocket-client jedi neovim
cd $HOME/tools
wget https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz
tar zxvf nvim-linux64.tar.gz
mkdir -p $HOME/{.config/nvim,bin}
cp nvim-linux64/bin/nvim $HOME/bin
sudo mkdir -p /share
sudo cp -R nvim-linux64/share/nvim/runtime /share/nvim
aws s3 cp s3://lkdjsflskdjflskdjf-dev-datascience/Dari/tools/init.vim $HOME/.config/nvim/
cd $HOME
############################################################################
