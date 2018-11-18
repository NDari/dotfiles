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
mkdir -p $HOME/tools
cd $HOME/tools
wget http://archive.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
tar zxvf spark-2.3.1-bin-hadoop2.7.tgz
echo '' >> $HOME/.bash_profile
echo 'export SPARK_HOME=$HOME/tools/spark-2.3.1-bin-hadoop2.7' >> $HOME/.bash_profile
echo 'export PATH=$SPARK_HOME/bin:$PATH' >> $HOME/.bash_profile

# Maven, and the needed jars to read from s3
wget http://apache.mirrors.ionfish.org/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
tar zxvf apache-maven-3.6.0-bin.tar.gz
$HOME/tools/apache-maven-3.6.0/bin/mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-aws:2.7.3
cp $HOME/.m2/repository/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar $HOME/tools/spark-2.3.1-bin-hadoop2.7/jars/
cp $HOME/.m2/repository/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar $HOME/tools/spark-2.3.1-bin-hadoop2.7/jars/
cd $HOME
source $HOME/.bash_profile

##### ZSH and Neovim set up
############################################################################
cd $HOME
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/\s*env\s\s*zsh\s*/d')"
rm .zshrc && ln -s dotfiles/.zshrc && ln -s dotfiles/.zlogout
echo "" >> $HOME/.bash_profile
echo 'export SHELL=`which zsh`' >> $HOME/.bash_profile
echo '[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l' >> $HOME/.bash_profile
git clone https://github.com/NDari/dotfiles.git
$HOME/miniconda3/bin/pip install sexpdata websocket-client jedi neovim
cd $HOME/tools
git clone https://github.com/neovim/neovim.git
cd neovim
make -j72 CMAKE_EXTRA_FLAGS='-DCMAKE_INSTALL_PREFIX=/home/ec2-user/.local/'
make install
cd $HOME
mkdir -p .config/nvim
cd .config/nvim
ln -s /home/ec2-user/dotfiles/init.vim
cd $HOME
############################################################################
