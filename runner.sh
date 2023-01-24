. /etc/profile.d/modules.sh
srcdir="$(dirname $0)"
. $srcdir/env.sh
cd $HOME

# Select either JupyterLab or Jupyter Notebook
#python -m jupyterlab.labhubapp $@
python -m jupyterhub.singleuser $@
