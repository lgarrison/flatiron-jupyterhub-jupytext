module load jupyterhub

srcdir="$(dirname $0)"
if [[ -f $srcdir/venv/bin/activate ]]; then
    . $srcdir/venv/bin/activate
fi
