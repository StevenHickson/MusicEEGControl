import time
import bluetooth
import scipy.io
import csv
import numpy as np
import numpy.linalg
import math
from mindwavemobile.MindwaveDataPoints import RawDataPoint
from mindwavemobile.MindwaveDataPointReader import MindwaveDataPointReader
from subprocess import call


if __name__ == '__main__':
    NUM_BAD = 4
    epsilon = 0.000001
    mat = scipy.io.loadmat('../model/modelBE.mat')
    m1 = np.array(mat['m1'].newbyteorder('='))
    m2 = np.array(mat['m2'].newbyteorder('='))
    s1 = (mat['s1'].newbyteorder('='))
    s2 = (mat['s2'].newbyteorder('='))
    s1_inv = np.matrix(np.linalg.pinv(s1))
    s2_inv = np.matrix(np.linalg.pinv(s2))
    lndet_sober = math.log(np.linalg.det(s1) + epsilon)
    lndet_drunk = math.log(np.linalg.det(s2) + epsilon)
    mindwaveDataPointReader = MindwaveDataPointReader()
    mindwaveDataPointReader.start()
    
    data = []
    i = 0
    signal_val = 0
    num_bad = 0
    while(True):
        dataPoint = mindwaveDataPointReader.readNextDataPoint()
        if (not dataPoint.__class__ is RawDataPoint):
		if (i == 0):
			data.append(float(dataPoint.meditationValue))
		elif (i == 1):
			data.append(float(dataPoint.attentionValue))
		elif (i == 2):
			data.append(float(dataPoint.delta))
			data.append(float(dataPoint.theta))
			data.append(float(dataPoint.lowAlpha))
			data.append(float(dataPoint.highAlpha))
			data.append(float(dataPoint.lowBeta))
			data.append(float(dataPoint.highBeta))
			data.append(float(dataPoint.lowGamma))
			data.append(float(dataPoint.midGamma))
		elif (i == 3):
			signal_val = float(dataPoint.amountOfNoise)
			if (signal_val == 0):
				data = np.array(data)
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
					num_bad = 0
				else:
					print "Bad Music"
					num_bad = num_bad + 1
					if (num_bad >= NUM_BAD):
						call(["control-pianobar.sh","n"])
						print("BAD SONG!!")	
						num_bad = 0
			else:
				print("Low Signal Value of {0}".format(signal_val))
		else:
			i = 0
			data = []
			data.append(float(dataPoint.meditationValue))
		i = i + 1;
        
