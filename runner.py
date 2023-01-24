import sys

# Select JupyterLab or Jupyter Notebook
# from jupyterlab.labhubapp import main
from jupyterhub.singleuser import main

sys.exit(main())
