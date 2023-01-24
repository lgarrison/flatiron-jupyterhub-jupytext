# JupyterHub with jupytext

*Instructions to get jupytext working with Flatiron JupyterHub*

[jupytext](https://jupytext.readthedocs.io) requires that the Lab/Notebook server be launched in a Python environment that has the Python jupytext package; this is different from other extensions, which just require a JS component and can be installed with the extension manager (https://wiki.flatironinstitute.org/SCC/JupyterHub#Customizing_jupyterlab).

This is also different from running a Jupyter kernel with a specific Python environment, which can be done by registering a custom kernel: https://wiki.flatironinstitute.org/SCC/JupyterHub#Registering_Custom_Kernels

The following instructions show you how to set up a custom Python environment that includes jupytext which can be launched from JupyterHub.

## Setup

Clone the repo:
```
$ git clone https://github.com/lgarrison/flatiron-jupyterhub-jupytext.git
```

Boostrap the venv:
```
$ . env.sh
$ python -m venv venv --system-site-packages
$ . env.sh  # again, to load the venv
```

Install jupytext:
```
$ jupyter lab build  # only for JupyterLab
$ python -m pip install jupytext
```

Create a symlink to the script that JupyterHub will run when you select the "custom" environment:
```
$ mkdir -p ~/.local/bin/
$ ln -s $(realpath jupyterhub-custom) ~/.local/bin/jupyterhub-custom
```

## Usage

On the https://jupyter.flatironinstitute.org page, select "custom (advanced)" from the "environment" dropdown.  Launching the server will open a Jupyter Notebook session with jupytext loaded.

If you want a JupyterLab session instead, uncomment the `jupyterlab` line in `runner.sh` and comment the line below it.

## Details

The `jupyterhub-custom` mechanism lets you launch an arbitrary Python script from JupyterHub.  But we actually want a shell script, since we want to run `module` commands and activate a venv.  So we use `execv` to run bash with the target `runner.sh` script.  From there, we just need to load the right Python environment and launch a Jupyter session with the arguments that were passed down from `jupyterhub-custom`.

While we used `jupytext` as the motivation for this setup, it should similarly work for any application where the Jupyter session itself needs to be running in a customized Python environment.
