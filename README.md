# JupyterHub with jupytext

Instructions to get jupytext working with Flatiron JupyterHub. jupytext requires that the Lab/Notebook server be launched in a Python environment that has the Python jupytext package, so we need to create such an environment and tell JupyterHub to launch from there.

## Setup

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
# create symlink:
$ mkdir -p ~/.local/bin/
$ ln -s $(realpath jupyterhub-custom) ~/.local/bin/jupyterhub-custom
```

## Usage

On the jupyter.flatironinstitute.org page, select "custom (advanced)" from the "environment" dropdown.
