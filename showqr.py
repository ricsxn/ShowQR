#!/usr/bin/env python2.7
from sys import stdin
from qrcode.main import QRCode, make
from qrcode.constants import *
from qrcode import image
from PIL import ImageFont
from PIL import ImageDraw

VER="1.2"
SHOWTXT=True
FONT='/Library/Fonts/Courier New.ttf'
FONTSZ=12
BANNER='http://ricsxn.duckdns.org/donate.html'
HEADER='ShowQR v%s' % VER

qr = QRCode()
for line in stdin:
    qr.add_data(line)
qr.make()
im = qr.make_image()
if SHOWTXT is True:
	font = ImageFont.truetype(FONT, FONTSZ, encoding='unic')
	text = BANNER.decode('utf-8')
	head = HEADER.decode('utf-8')
	(txt_width, txt_height) = font.getsize(text)
	(hdr_width, hdr_height) = font.getsize(head)
	(qr_width,qr_height) = im.size
	draw = ImageDraw.Draw(im)
	draw.text(((qr_width-hdr_width)/2, 1),head,font=font)
	draw.text(((qr_width-txt_width)/2, qr_height-txt_height-1),text,font=font) 
im.show()
