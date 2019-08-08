import os, argparse, sys
if float(sys.version[:3])<3.0:
    execfile(os.path.join(os.environ['HOME'], '.pystartup'))
import numpy as np
import datetime as dt
from scipy.io import loadmat

proj_dir = os.path.join(os.environ['PROJ'], 'Matt_Jones_Data')
mat_dir = os.path.join(proj_dir, 'mat')

pos_file = loadmat(os.path.join(mat_dir, 'fghij-pos.mat'))
tmaze = loadmat(os.path.join(mat_dir, 'Tmaze-cells-021115.mat'))

mouse_name = 'Felix'

def getMouseEpochTimes(mouse_name, tmaze, time_bin=20):
    epoch_mouse_ind = np.flatnonzero([name[0] == mouse_name for name in tmaze['epochs'][:,0]])[0]
    pre_sleep_start = tmaze['epochs'][epoch_mouse_ind, 1][0][0] * 1000 / time_bin # seconds
    pre_sleep_end = tmaze['epochs'][epoch_mouse_ind, 2][0][0] * 1000 / time_bin # seconds
    maze_time_start = tmaze['epochs'][epoch_mouse_ind, 3][0][0] * 1000 / time_bin
    maze_time_end = tmaze['epochs'][epoch_mouse_ind, 4][0][0] * 1000 / time_bin
    sleep_start = tmaze['epochs'][epoch_mouse_ind, 5][0][0] * 1000 / time_bin
    sleep_end = tmaze['epochs'][epoch_mouse_ind, 6][0][0] * 1000 / time_bin
    return pre_sleep_start, pre_sleep_end, maze_time_start, maze_time_end, sleep_start, sleep_end
