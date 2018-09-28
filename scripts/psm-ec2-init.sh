sudo yum -y update
sudo yum -y install \
	ninja-build \
	libtool \
	autoconf \
	automake \
	cmake \
	gcc \
	gcc-c++ \
	make \
	pkgconfig \
	unzip \
	git \
	zsh \
	util-linux-user.x86_64 \
    java-1.8.0-openjdk-devel.x86_64

mkdir -p $HOME/local/bin
mkdir -p $HOME/tools

##### ZSH set up
############################################################################
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "" >> $HOME/.bash_profile
echo 'export SHELL=`which zsh`' >> $HOME/.bash_profile
echo '[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l' >> $HOME/.bash_profile
############################################################################

# Python3 setup
wget "https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh"
chmod +x Miniconda3-4.5.4-Linux-x86_64.sh
./Miniconda3-4.5.4-Linux-x86_64.sh -b -p $HOME/miniconda3
export PATH=$PATH:$HOME/miniconda3/bin
conda config --set always_yes yes --set changeps1 no
conda config -f --add channels conda-forge
conda config -f --add channels bioconda
conda config -f --add channels default

conda install \
    beautifulsoup4 \
    bokeh \
    cython \
    dask \
    datashader \
    fastdtw \
    findspark \
    fiona \
    folium \
    geopandas \
    hdfs3 \
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

##### Scala
curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
sudo yum install -y sbt
cd tools
wget http://downloads.typesafe.com/scala/2.11.12/scala-2.11.12.tgz
tar zxvf scala-2.11.12.tgz
cd $HOME
echo "" >> $HOME/.zshrc
echo 'export SCALA_HOME=/home/ec2-user/scala-2.11.12' >> $HOME/.zshrc
echo 'export PATH=/home/ec2-user/scala-2.11.12:$PATH' >> $HOME/.zshrc
source $HOME/.zshrc
cd local/bin
curl -L -o coursier https://git.io/vgvpD && chmod +x coursier
cd $HOME

### spark
cd $HOME/tools
wget http://archive.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
tar zxvf spark-2.3.1-bin-hadoop2.7.tgz
echo "" >> $HOME/.zshrc
echo 'export SPARK_HOME=$HOME/tools/spark-2.3.1-bin-hadoop2.7' >> $HOME/.zshrc
echo 'export PATH=$SPARK_HOME/bin:$PATH' >> $HOME/.zshrc

##### Install neovim
###########################################################################
pip install sexpdata websocket-client jedi neovim
cd tools
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/local/"
make install
cd $HOME
git clone https://github.com/NDari/dotfiles.git
mkdir -p .config/nvim
mkdir .config/nvim/backup
mkdir .config/nvim/swp
mkdir .config/nvim/undodir
cd .config/nvim
ln -s /home/ec2-user/dotfiles/init.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd $HOME
############################################################################

