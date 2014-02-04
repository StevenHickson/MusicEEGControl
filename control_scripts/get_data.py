from __future__ import print_function
import time
import bluetooth
import scipy.io
import numpy as np
import numpy.linalg
import math
from mindwavemobile.MindwaveDataPoints import RawDataPoint
from mindwavemobile.MindwaveDataPointReader import MindwaveDataPointReader
import sys

if __name__ == '__main__':
    mindwaveDataPointReader = MindwaveDataPointReader()
    mindwaveDataPointReader.start()
    
    data = []
    i = 0
    signal_val = 0
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
				#print ", ".join(data)
				print(data)
			else:
				print("WARNING bad signal value of: ", signal_val, file=sys.stderr)
		else:
			i = 0
			data = []
			data.append(float(dataPoint.meditationValue))
		i = i + 1;
        
