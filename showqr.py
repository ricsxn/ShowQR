#!/usr/bin/env python2.7
import tempfile
from os  import remove 
from sys import stdin
from subprocess import Popen, PIPE
from qrcode import *

qr = QRCode()
for line in stdin:
    qr.add_data(line)
qr.make()
im = qr.make_image()
temp = tempfile.NamedTemporaryFile(dir='/tmp')
im.save(temp.name)
pr=Popen("{}; {}".format('open %s' % temp.name,'sleep 5'),shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE, close_fds=True)
stdout,stderr = pr.communicate()
