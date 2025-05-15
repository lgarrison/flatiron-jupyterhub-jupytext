# Flatiron JupyterHub with jupytext

*Instructions to get jupytext working with Flatiron JupyterHub*

[jupytext](https://jupytext.readthedocs.io) requires that the Lab/Notebook server be launched in a Python environment that has the Python jupytext package; this is different from other extensions, which just require a JS component and can be installed with the extension manager (https://wiki.flatironinstitute.org/SCC/JupyterHub#Customizing_jupyterlab).

This is also different from running a Jupyter kernel with a specific Python environment, which can be done by registering a custom kernel: https://wiki.flatironinstitute.org/SCC/JupyterHub#Registering_Custom_Kernels

Currently only JupyterLab is supported with these instructions, not classic notebooks.

The following instructions show you how to set up a custom Python environment that includes jupytext which can be launched from JupyterHub.

## Setup

Clone the repo:
```
$ git clone https://github.com/lgarrison/flatiron-jupyterhub-jupytext.git
$ chmod a+x flatiron-jupyterhub-jupytext/jupyterhub-custom  # ensure executable
```

Boostrap the venv:
```
$ cd flatiron-jupyterhub-jupytext
$ . env.sh
$ python -m venv venv --system-site-packages
$ . env.sh  # again, to load the venv
```

Create a `~/.jupyter/jupyter_config.py` (from https://wiki.flatironinstitute.org/SCC/JupyterHub#Customizing_jupyterlab):
```
c.JupyterApp.app_dir="/mnt/home/lgarrison/.local/share/jupyter/lab"
c.LabBuildApp.dev_build=False
```

Install jupytext:
```
$ python -m pip install jupytext
$ jupyter lab build
```

Create a symlink to the script that JupyterHub will run when you select the "custom" environment:
```
$ mkdir -p ~/.local/bin/
$ ln -s $(realpath jupyterhub-custom) ~/.local/bin/jupyterhub-custom
```

## Usage

On the https://jupyter.flatironinstitute.org page, select "custom (advanced)" from the "environment" dropdown.  Launching the server will open a Jupyter session with jupytext loaded.

## Details

The `jupyterhub-custom` mechanism lets you launch an arbitrary Python script from JupyterHub. Internally, our JupyterHub uses a `pyexec` script that will `execvp` the args, so effectively we can run any kind of script. In this case, we run a bash script to load the right Python environment and launch a Jupyter session with the arguments that were passed down from `jupyterhub-custom` (i.e. port number).

While we used `jupytext` as the motivation for this setup, it should similarly work for any application where the Jupyter session itself needs to be running in a customized Python environment.
