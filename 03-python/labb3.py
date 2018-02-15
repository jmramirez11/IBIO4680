#!/usr/bin/python
import glob
import os
import tarfile
import urllib.request
cur_path=os.path.dirname(os.path.abspath('labb3.py'))
bool_untar=os.path.isdir('BSR')
bool_tar=os.path.isfile('BSR_bsds500.tgz')
if ( bool_tar==True and bool_untar==False ):
	tar=tarfile.open("BSR_bsds500.tgz")
	tar.extractall()
	tar.close()
elif ( bool_tar==False and bool_untar==False ):
	url='http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/BSR/BSR_bsds500.tgz'
	response=urllib.request.urlopen(url)
	urllib.request.urlretrieve(url,'BSR_bsds500.tgz')
	tar = tarfile.open("BSR_bsds500.tgz")
	tar.extractall()
	tar.close()
else:
	pass

from PIL import Image
import os, os.path
total_path = cur_path+'/BSR/BSDS500/data/images/train/'
a = os.listdir(total_path)

from random import randint
N = randint(6,15)

import numpy as np 
a_array = np.asarray(a)

im_selecc = [randint(0,200) for x in range(0,N)]
nombres_ima = a_array[im_selecc]

import cv2
import numpy as npinstal
from PIL import Image

Direccion = [None]*N
keys = [None]*N
directory = 'Imagenes_selecc/'
folder = total_path+directory
if not os.path.exists(folder):
	os.makedirs(folder)

for i in range(N):
	Direccion[i] = total_path+nombres_ima[i]
	im =(Image.fromarray(cv2.imread(Direccion[i]))).resize((256,256))
	im.save(folder+nombres_ima[i],'JPEG')

Dictionary = {key:[] for key in nombres_ima}
print(Dictionary)




