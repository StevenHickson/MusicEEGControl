import time
import bluetooth
import scipy.io
import csv
import numpy as np
import numpy.linalg
import math
from collections import deque
from mindwavemobile.MindwaveDataPoints import RawDataPoint
from mindwavemobile.MindwaveDataPointReader import MindwaveDataPointReader


if __name__ == '__main__':
    epsilon = 0.000001;
    mat = scipy.io.loadmat('../model/modelBE3.mat')
    m1 = np.array(mat['m1'].newbyteorder('='))
    m2 = np.array(mat['m2'].newbyteorder('='))
    s1 = (mat['s1'].newbyteorder('='))
    s2 = (mat['s2'].newbyteorder('='))
    s1_inv = np.matrix(np.linalg.pinv(s1))
    s2_inv = np.matrix(np.linalg.pinv(s2))
    means = (mat['means'].newbyteorder('='))
    stds = (mat['stds'].newbyteorder('='))
    
    mat2 = scipy.io.loadmat('../model/fft_results.mat')
    sober_fft = np.array(mat2['sober_reserved'].newbyteorder('='))
    drunk_fft = np.array(mat2['drunk_reserved'].newbyteorder('='))
    lndet_sober = math.log(np.linalg.det(s1) + epsilon)
    lndet_drunk = math.log(np.linalg.det(s2) + epsilon)
    d = np.array([]) 
    myfile = open('test_file',"r")
    csv_reader = csv.reader(myfile)
    for row in csv_reader:
	data = np.array((float(row[0]),float(row[1]),float(row[2]),float(row[3]),float(row[4]), \
 	float(row[5]),float(row[6]),float(row[7]),float(row[8]),float(row[9]))).reshape(1,10)
	tmp = np.subtract(data,means);
	data = np.divide(tmp,stds);
	size = len(d)
	if (size == 0):
		d = data
	else:
		d = np.vstack((d,data))
	if (size == 9):
		d_fft = np.fft.fft(np.matrix(d), axis=0)
		data = d_fft[0,:]
		d = np.delete(d, (0), axis=0)
		tmp = np.subtract(data,m1)
		matrix_mult = \
       		np.matrix(tmp) * \
       		np.matrix(s1_inv) * \
       		np.matrix(tmp).T
		part2 = math.log(0.5) - 5*math.log(2*math.pi) - 0.5*lndet_sober
       		g1=-0.5*matrix_mult + part2
		tmp = np.subtract(data,m2)
		matrix_mult = \
       		np.matrix(tmp) * \
       		np.matrix(s2_inv) * \
       		np.matrix(tmp).T
		part2 = math.log(0.5) - 5*math.log(2*math.pi) - 0.5*lndet_drunk
       		g2=-0.5*matrix_mult + part2
		decision = g1 - g2
		if decision > 0:
			print "Good Music"
		else:
			print "Bad Music"
