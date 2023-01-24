. /etc/profile.d/modules.sh
srcdir="$(dirname $0)"
. $srcdir/env.sh
cd $HOME
python $srcdir/runner.py $@
