# The following startup file creates a dated log file of all input and output in
# the log folder of the given profile. If the file already exists, it appends to
# it, writing a time stamp indicating the creation of a new session.

# Put in a file 05_log.py in the startup/ directory of your profile.
# For example, ~/.ipython/profile_default/startup/05_log.py:
from time import strftime
import os.path

ip = get_ipython()

ldir = ip.profile_dir.log_dir
fname = 'log-' + ip.profile + '-' + strftime('%Y-%m-%d') + ".py"
filename = os.path.join(ldir, fname)
notnew = os.path.exists(filename)

try:
    ip.magic('logstart -o %s append' % filename)
    if notnew:
        ip.logger.log_write(u"# =================================\n")
    else:
        ip.logger.log_write(u"#!/usr/bin/env python\n" )
        ip.logger.log_write(u"# " + fname + "\n" )
        ip.logger.log_write(u"# IPython automatic logging file\n" )
    ip.logger.log_write(u"# " + strftime('%H:%M:%S') + "\n" )
    ip.logger.log_write(u"# =================================\n" )
    print(" Logging to "+filename)
except RuntimeError:
    print(" Already logging to "+ip.logger.logfname)
