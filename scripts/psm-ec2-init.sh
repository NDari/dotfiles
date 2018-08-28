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
	util-linux-user.x86_64

mkdir -p $HOME/local/bin
mkdir -p $HOME/tools

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
wget "https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh"
chmod a+x Miniconda3-4.5.4-Linux-x86_64.sh
./Miniconda3-4.5.4-Linux-x86_64.sh -b -p $HOME/miniconda3

export PATH=$PATH:$HOME/miniconda3/bin

conda config --set always_yes yes --set changeps1 no
conda config -f --add channels conda-forge
conda config -f --add channels bioconda
conda config -f --add channels default

pip install sexpdata websocket-client jedi neovim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# sudo yum install tmux
# wget "https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
# chmod a+x Miniconda3-latest-Linux-x86_64.sh
# ./Miniconda3-latest-Linux-x86_64.sh
# which python3
# vim .zshrc
# exec zsh -l
# sudo yum -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip\n
# mkdir local
# git clone https://github.com/neovim/neovim.git
# cd neovim
# which nvim
# mkdir .config
# mkdir .config/nvim
# cd .config/nvim
# ln -s /home/ec2-user/dotfiles/init.vim
# curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# nvim
# mkdir .config/nvim/backup
# mkdir .config/nvim/swp
# mkdir .config/nvim/undodir
# conda install scipy numpy pandas matplotlib ipython shapely
# fzf
# yum search silver
# yum search ag
# yum search ag | grep silver
# aws credentials
# conda install dask pyarrow
# conda install knit
# e hi.py
# aws s3
# mv src tools
# mkdir Projects
# mkdir notebooks
# pwd
# yum search java | grep jdk
# sudo yum install java-1.8.0
# e .ipython/profile_default/startup/README
# ipython profile create
# e .ipython/profile_default/ipython_config.py
# aws configure
# conda install s3fs
# sudo yum install -y gcc-c++ libX11-devel fontconfig-devel\nlibXcursor-devel libXext-devel ibXfixes libXft-devel libXi-devel libXrandr-devel libXrender-devel
# sudo cat /etc/ssh/sshd_config |grep -i x11
# sudo e /etc/ssh/ssh_config
# sudo vim /etc/ssh/ssh_config
# sudo vim /etc/ssh/sshd_config
# sudo yum install xorg-x11-xauth.x86_64 xorg-x11-server-utils.x86_64 dbus-x11.x86_64\n
# echo $DISPLAY
# conda install spyder
# yum search libgl
# sudo yum install libgl
# sudo yum install -y mesa-libGL.x86_64
# yum search libsel
# sudo yum install -y libselinux.x86_64
# conda install pyqt
# DISPLAY=:0 spyder &
# export DISPLAY=:0
# spyder
# c
# ln -s dotfiles/.tmux.conf
# w
# sudo yum install xclip
# yum search xclip
# yum search vim
# yum search all vim
# yum search xsel
# tns py
# tl
# .
# mkdir bin
# chmod a+x lein
# echo path
# echo $PATH
# mv dotfiles/bin .
# aws s3 cp "s3://psm-sta-ues/ues/2018/06/20/09/i-0be0c226e140b093f-objectlog-intelligence.log.2018-06-20-09-02.gz" .
# sudo yum install -y libcurl libcurl-devel graphviz cyrus-sasl cyrus-sasl-devel readline readline-devel gnuplot\n\tsudo yum install -y automake fuse fuse-devel libxml2-devel\n
# git clone https://github.com/s3fs-fuse/s3fs-fuse.git\n\tcd s3fs-fuse/\n\tls -alrt\n\t./autogen.sh\n\t./configure\n\tmake\n\tsudo make install\n\tsudo su -c 'echo user_allow_other >> /etc/fuse.conf'\n
# rm s3fs-fuse
# rm -r s3fs-fuse
# rm -rf s3fs-fuse
# git clone https://github.com/s3fs-fuse/s3fs-fuse.git
# yum search libcrypt
# sudo yum install -y libcrypt.x86_64
# sudo yum install -y libcrypt-nss.x86_64
# pkg-config
# pkg-config libcrypto
# pkg-config libcrypt
# ldconfig -p | grep libcryp
# conda install jupyter lab
# conda install jupyterlab
# jupyter --runtime-dir
# ipython kernel
# cd notebooks
# rm i-*
# rm 1.py
# mkdir sessions
# cd sessions
# cd Projects/sessions
# e of-lsdk-test.py
# ipython
# sudo yum install nodejs
# tmux new-session -t jupyter
# tmux new-session
# screen
# screen -S test -d jupyter lab --no-browser --port=9191
# screen -S jupyter -d jupyter lab --no-browser --port=9191
# pkill 5894
# kill 5894
# aws s3 cp "s3://datascience-emr/Dari/notebooks/dask/Untitled.ipynb" .
# yum search htop
# sudo yum install -y htop
# clear
# wget http://archive.apache.org/dist/spark/spark-2.3.1-bin-hadoop2.7.tgz
# wget http://archive.apache.org/dist/spark/spark-2.3.0-bin-hadoop2.7.tgz
# yum search spark
# http://archive.apache.org/dist/spark/spark-2.0.0/spark-2.3.0-bin-hadoop2.7.tgz
# wget http://archive.apache.org/dist/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.7.tgz
# wget http://archive.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
# rm spark-2.3.0-bin-hadoop2.7.tgz
# tar zxvf spark-2.3.1-bin-hadoop2.7.tgz
# pyspark --packages --packages com.amazonaws:aws-java-sdk-pom:1.11.351,org.apache.hadoop:hadoop-aws:2.7.7
# pyspark --packages com.amazonaws:aws-java-sdk-pom:1.11.351,org.apache.hadoop:hadoop-aws:2.7.7
# pyspark --packages com.amazonaws:aws-java-sdk-pom:1.11.351,org.apache.hadoop:hadoop-aws:2.7.6
# conda install pyspark
# ip[
# kill 5945
# jupyter lab --no-browser --port=9191 &
# conda install fastparquet pyarrow -c conda-forge
# ps
# jupyter lab --no-browser --port=919
# git checkout init.vim
# echo $GOPATH
# mkdir go
# cd go
# mkdir src
# cd src
# mkdir read_raw
# cd read_raw
# wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz .
# sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
# go get -u golang.org/x/vgo
# cd go/src/read_raw
# touch go.mod
# go get -u github.com/scritchley/orc
# vgo vendor
# vgo mod -vendor
# cd -
# e main.go
# vgo build
# ./read_raw
# $ sudo sh -c '(echo "#!/usr/bin/env sh" && curl -L https://github.com/lihaoyi/Ammonite/releases/download/1.1.2/2.12-1.1.2) > /usr/local/bin/amm && chmod +x /usr/local/bin/amm' && amm\n
# sudo sh -c '(echo "#!/usr/bin/env sh" && curl -L https://github.com/lihaoyi/Ammonite/releases/download/1.1.2/2.12-1.1.2) > /usr/local/bin/amm && chmod +x /usr/local/bin/amm' && amm\n
# ls .ammonite/
# scala
# sudo sh -c '(echo "#!/usr/bin/env sh" && curl -L https://github.com/lihaoyi/Ammonite/releases/download/1.1.2/2.11-1.1.2) > /usr/local/bin/amm && chmod +x /usr/local/bin/amm' && amm\n
# ls go/src/read_raw/000000_0
# top
# htop
# mkdir scripts
# cd scripts
# e ipython_dated_logs.py
# cp ipython_dated_logs.py ~/.ipython/profile_default/startup/
# e ~/.ipython/profile_default/startup/README
# cd .ipython/profile_default/startup
# mv ipython_dated_logs.py
# mv ipython_dated_logs.py 05_log.py
# e ~/.ipython/profile_default/log/log-default-2018-06-22.py
# mv ~/
# conda install python-snappy
# ls output
# ls output/\*.parquet
# cd \*.parquet
# cd output
# cd 000000_0.parquet
# du -sh output
# du -sh 000000_0.parquet
# rm -r output 000000_0.parquet metastore_db spark-warehouse derby.log
# rm Miniconda3-latest-Linux-x86_64.sh \\n
# cd output2
# du -sh output2
# du -sh go/src/read_raw/000000_0
# cat session1.py
# e session1.py
# tail -n 20 session1.py > Projects/query-ues.py
# conda install cython numba
# cat Projects/query-ues.py
# nano .ptpython/config.py
# e .ptpython/config.py
# pip reinstall ptpython
# pip install prompt_toolkit
# conda install prompt_toolkit
# pip install ptpython
# ptpython
# pip uninstall ptpython
# conda uninstall prompt_toolkit
# cd bin
# e lein
# yum search emacs
# yum info emacs
# yum info emacs-nox
# yum groupinstall "Development Tools"
# sudo yum groupinstall "Development Tools"
# yum install gtk+-devel, gtk2-devel, libXpm-devel, libpng-devel, giflib-devel, libtiff-devel, libjpeg-devel, ncurses-devel, gpm-devel, dbus-devel, dbus-glib-devel, dbus-python, GConf2-devel, pkgconfig, libXft-devel
# sudo yum install gtk+-devel, gtk2-devel, libXpm-devel, libpng-devel, giflib-devel, libtiff-devel, libjpeg-devel, ncurses-devel, gpm-devel, dbus-devel, dbus-glib-devel, dbus-python, GConf2-devel, pkgconfig, libXft-devel
# wget ftp.gnu.org/pub/gnu/emacs/emacs-26.1.tar.xz
# tar zxvf emacs-26.1.tar.xz
# tar xvJF emacs-26.1.tar.xz
# tar xvJf emacs-26.1.tar.xz
# cd emacs-26.1
# yum install libXpm libjpeg libgif/libungif libtiff gnutls
# sudo yum install libXpm libjpeg libgif/libungif libtiff gnutls
# yum install libgif
# sudo yum install libgif
# yum search libgif
# yum search gif
# sudo yum install giflib giflib-devel
# yum search Xpm
# yum search jpeg
# yum search tiff
# yum search libXpm libXpm-devel libjpeg-turbo
# sudo yum install libXpm libXpm-devel libjpeg-turbo
# sudo yum install libtiff libtiff-devel
# yum search gnutls
# sudo yum install gnutls gnutls-devel
# yum search libjpeg
# sudo yum install libjpeg-turbo-devel.x86_64
# ./configure --with-x-toolkit=no
# e Makefile
# make all
# make clearn
# make clean
# ./configure --with-x-toolkit=no --with-jpeg
# ./configure --with-x-toolkit=no --with-jpeg=no
# ./configure --with-x-toolkit=no --with-jpeg=no --with-png=no
# make all -j64
# make install
# which emacs
# emacs --version
# git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d\n
# emacs --insecure
# mkdir spark-clj
# which python
# python
# pip install jedi neovim
# rm hi.py
# e .lein/profiles.clj
# rm -rf spark-clj
# lein new app spark-clj
# cd spark-clj
# e project.clj
# vim
# ^A
# fg
# e .lein-repl-history
# emacs .
# cd Projects/spark-clj
# lein repl
# e query-ues.py
# cat query-ues.py
# history
# spark-shell --packages com.amazonaws:aws-java-sdk-pom:1.11.351,org.apache.hadoop:hadoop-aws:2.7.6
# e init.vim
# scala -version
# yum search scala
# sbt --version
# e .ammonite/predef.sc
# amm
# which spark
# spark-shell --packages com.amazonaws:aws-java-sdk-pom:1.7.4,org.apache.hadoop:hadoop-aws:2.7.6
# spark-shell --packages com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.6
# .aws/credentials
# e .aws/credentials
# e tools/spark-2.3.1-bin-hadoop2.7/conf/spark-defaults.conf.template
# cd tools/spark-2.3.1-bin-hadoop2.7
# rm *.tgz
# rm go1.10.3.linux-amd64.tar.gz
# rm emacs-26.1.tar.xz
# cd spark-2.3.1-bin-hadoop2.7
# cd conf
# cp spark-defaults.conf.template spark-defaults.conf
# e core-site.xml
# e spark-defaults.conf
# mkdir jars
# cd ja
# cd jars
# http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar
# wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar
# wget http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.6/hadoop-aws-2.7.6.jar
# rm tools/spark-2.3.1-bin-hadoop2.7/conf/core-site.xml
# mv tools/spark-2.3.1-bin-hadoop2.7/conf/jars .
# ls jars
# e tools/spark-2.3.1-bin-hadoop2.7/conf/spark-defaults.conf
# spark-shell
# pyspark
# sbt
# yum search sbt
# curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
# sudo yum install -y sbt
# PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS='lab --no-browser --port=9191' pyspark
# PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS='lab --port=9191' pyspark
# jupyter-lab
# PYSPARK_DRIVER_PYTHON=jupyter-lab PYSPARK_DRIVER_PYTHON_OPTS='--port=8889' pyspark
# PYSPARK_DRIVER_PYTHON=jupyter-lab PYSPARK_DRIVER_PYTHON_OPTS='--no-browser --port=8889' pyspark
# PYSPARK_DRIVER_PYTHON=jupyter-lab pyspark
# conda install ipython
# which jl
# jl
# cat tools/spark-2.3.1-bin-hadoop2.7/conf/spark-defaults.conf
# ./autogen.sh
# ./configure
# sudo yum install -y libcurl libcurl-devel graphviz cyrus-sasl cyrus-sasl-devel readline readline-devel gnuplot automake fuse fuse-devel libxml2-devel
# yum search libcrypto
# yum install -y gcc libstdc++-devel gcc-c++ fuse fuse-devel curl-devel libxml2-devel mailcap automake openssl-devel
# sudo yum install -y gcc libstdc++-devel gcc-c++ fuse fuse-devel curl-devel libxml2-devel mailcap automake openssl-devel
# ./configure --prefix=/usr --with-openssl
# make
# sudo make install
# cd tools
# cd s3fs-fuse
# cd ~/Projects
# mkdir ~/s3fs-cache
# sudo su -c 'echo user_allow_other >> /etc/fuse.conf'
# mv * ../notebooks
# e .passwd_s3fs
# mv .passwd_s3fs .passwd-s3fs
# /usr/bin/s3fs -o allow_other -o iam_role=auto -o umask=0 -o url=https://s3.amazonaws.com -o no_check_certificate -o enable_noobj_cache -o use_cache=/home/ec2-user/s3fs-cache ipynb-datascience /home/ec2-user/Projects/ipynb-datascience
# /usr/bin/s3fs -o allow_other -o iam_role=auto -o umask=0 -o url=https://s3.amazonaws.com -o no_check_certificate -o enable_noobj_cache -o use_cache=/home/ec2-user/s3fs-cache ipynb-datascience /mnt
# ls s3fs-cache
# ip
# conda install ptpython
# conda install -c prkrekel ptpython
# git stash pop
# gc -m 'Fix .zshrc'
# unlink .spacemacs
# rm -rf .emacs.d
# ln -s dotfiles/.emacs
# emacs
# cd Projects/notebooks
# mv spark-clj ../
# cd dask-test
# ..
# jupyter lab --no-browser --port=9191
# s3fs ipynb-datascience /mnt
# e .passwd-s3fs
# cp .passwd-s3fs /etc/passwd-s3fs
# sudo cp .passwd-s3fs /etc/passwd-s3fs
# chmod 600 .passwd-s3fs
# sudo chmod 640 /etc/passwd-s3fs
# sudo s3fs ipynb-datascience /mnt
# sudo s3fs ipynb-datascience /home/ec2-user/Projects
# sudo s3fs ipynb-datascience /home/ec2-user/Projects/ipynb-datascience
# sudo ls ipynb-datascience/
# fusermount -u ipynb-datascience
# unmount ipynb-datascience
# rm ipynb-datascience
# rm -r ipynb-datascience
# s3fs ipynb-datascience /home/ec2-user/Projects/
# mkdir ipynb-datascience
# s3fs ipynb-datascience /home/ec2-user/Projects/ipynb-datascience
# cd Dari
# ls -la
# chown Dari
# chown --help
# whoemi
# whoami
# chown ec2-user Dari
# sudo chown ec2-user Dari
# chmod --help
# umount ipynb-datascience
# sudo umount ipynb-datascience
# s3fs ipynb-datascience /home/ec2-user/Projects/ipynb-datascience -o use_cache=/tmp -o umask=0022
# ls ipynb-datascience
# ls ipynb-datascience/Dari/
# cd ipynb-datascience/Dari
# mkdir ec2
# cd dask
# cp ~/Projects/dask-test/main.ipynb .
# sudo cp ~/Projects/dask-test/main.ipynb .
# sudo umount /home/ec2-user/Projects/ipynb-datascience
# which pip
# pip install sexpdata websocket-client
# pip --upgrade pip
# pip install --upgrade pip
# e .tmux.conf
# tmux
# cd ipynb-datascience
# sudo /usr/bin/s3fs -o allow_other -o iam_role=auto -o umask=0 -o url=https://s3.amazonaws.com -o no_check_certificate -o enable_noobj_cache -o use_cache=/home/ec2-user/s3fs-cache ipynb-datascience /mnt
# ls Projects/ipynb-datascience
# which spark-shell
# cd Projects/ipynb-datascience
# sudo yum updates
# sudo yum update
# e scripts/05_log.py
# git diff init.vim
# git diff .tmux.conf
# git stash
# git pull
# git diff .zshrc
# ga .zshrc
# gc
# which sbt
# cd Projects
# which clj
# which lein
# lein
# mkdir .sbt/1.0/plugins
# e .sbt/1.0/plugins/plugins.sbt
# cd Projects/
# rm -rf overreach
# which java
# yum search java
# sudo yum install java-1.8.0-openjdk.x86_64
# file `which java`
# /etc/alternatives/java
# file /etc/alternatives/java
# yum install java-1.8.0-openjdk-devel.x86_64
# sudo yum install java-1.8.0-openjdk-devel.x86_64
# e .zshrc
# source .zshrc
# echo $JAVA_HOME
# sbt new scala/scala-seed.g8
# cd overreach
# which javac
# sbt package
# tree
# e project/assembly.sbt
# e build.sbt
# e ensime.sbt
# yum search jdk
# sudo yum install java-1.8.0-openjdk-javadoc.noarch
# sbt ensimeConfig
# cd src/main/scala/example
# ls
# pip install websocket-client sexpdata
# e Hello.scala
# exit
# aws s3 ls
# e
# h
# ls scripts
# cat scripts/05_log.py
# cd
# cd dotfiles
# gst
# git diff
# ls /mnt
# cd ..
