#!/usr/bin/env sh

sudo yum -y update
sudo yum -y install \
    autoconf \
    automake \
    cmake \
    gcc \
    gcc-c++ \
    git \
    libtool \
    make \
    ninja-build \
    patch \
    pkgconfig \
    unzip \
    util-linux-user.x86_64 \
    zsh \
    java-1.8.0-openjdk-devel.x86_64

mkdir -p $HOME/.local/bin

# Python3 setup
############################################################################
cd $HOME
wget 'https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh'
chmod +x Miniconda3-4.5.4-Linux-x86_64.sh
./Miniconda3-4.5.4-Linux-x86_64.sh -b -p $HOME/miniconda3
echo '' >> $HOME/.bash_profile
echo 'export PATH=$HOME/miniconda3/bin:$PATH' >> $HOME/.bash_profile
source $HOME/.bash_profile

$HOME/miniconda3/bin/pip install --upgrade pip

$HOME/miniconda3/bin/pip install \
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

# Maven, and the needed jars to read from s3
wget http://apache.mirrors.ionfish.org/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
tar zxvf apache-maven-3.6.0-bin.tar.gz
$HOME/tools/apache-maven-3.6.0/bin/mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-aws:2.7.3
cp $HOME/.m2/repository/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar $HOME/tools/spark/jars/
cp $HOME/.m2/repository/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar $HOME/tools/spark/jars/
cd $HOME
source $HOME/.bash_profile

##### ZSH and Neovim set up
############################################################################
NVIM_VERSION="0.3.2"
$HOME/miniconda3/bin/pip install sexpdata websocket-client jedi neovim
cd $HOME/tools
wget https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz
tar zxvf nvim-linux64.tar.gz
mkdir -p $HOME/{.config/nvim,bin}
cp nvim-linux64/bin/nvim $HOME/bin
sudo mkdir -p /share
sudo cp -R nvim-linux64/share/nvim/runtime /share/nvim
aws s3 cp s3://psm-dev-datascience/Dari/tools/init.vim $HOME/.config/nvim/
cd $HOME
############################################################################
