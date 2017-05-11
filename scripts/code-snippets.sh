# generate ctags for all modules accessible to the current python installation
libs=($(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))" | tr -d '[],')); ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./.tags $libs
