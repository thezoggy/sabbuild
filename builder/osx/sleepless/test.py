#!/usr/bin/env python

import sleepless
import sys
import time
from subprocess import Popen, PIPE

def show_state():
    output = Popen(["pmset", "-g", "assertions"], stdout=PIPE).communicate()[0]
    for line in output.split('\n'):
        if 'SABnzbd' in line:
            return line
    return 'Nothing'

    
msg = u"SABnzbd is r\xe8nning"
print msg

print show_state()
print "Starting assertion"
for n in xrange(6):
    sleepless.keep_awake(msg)
    time.sleep(1)
    print show_state()
print "Stopping assertion"
sleepless.allow_sleep()
print show_state()
print "Done"
