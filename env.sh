module load jupyterhub

srcdir="$(dirname ${BASH_SOURCE[0]})"
if [[ -f $srcdir/venv/bin/activate ]]; then
    . $srcdir/venv/bin/activate
fi
