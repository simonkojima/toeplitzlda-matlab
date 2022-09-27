import sys
import os

import numpy as np

from blockmatrix import SpatioTemporalMatrix, BlockMatrix
from blockmatrix.utils import get_example_raw


import numpy as np
"""

home_dir = os.path.expanduser('~')
git_dir = os.path.join(home_dir,'git')
sys.path.append(git_dir)
from pylibs.classification import EpochsVectorizer

dir = os.path.join(home_dir,'Documents','eeg','oddball', 'oddball_1.vhdr')

markers_non_target = [1]
markers_target = [5]
markers_to_epoch = markers_non_target + markers_target

filt_freq = [0.5, 8]
resample_freq = 100
t_range = [-0.2, 1.2]
baseline=None

reject = dict(eeg=200e-6, eog=600e-6)

eog_channels = ['EOGvu']
misc_channels = ['x_EMGl', 'x_GSR', 'x_Respi', 'x_Pulse', 'x_Optic']


ivals = [[0.08, 0.15],
        [0.151, 0.21],
        [0.211, 0.28],
        [0.271, 0.35],
        [0.351, 0.44],
        [0.45, 0.56],
        [0.561, 0.7],
        [0.701, 0.85],
        [0.851, 1],
        [1.001, 1.2]]

import mne
raw = mne.io.read_raw_brainvision(dir, preload=True, eog=eog_channels, misc=misc_channels)
raw.filter(filt_freq[0], filt_freq[1], picks='all', method='iir')
if resample_freq is not None:
        raw.resample(sfreq=resample_freq)
events, _ = mne.events_from_annotations(raw)
epochs= mne.Epochs(raw, events, event_id=markers_to_epoch, tmin=t_range[0], tmax=t_range[1], baseline=baseline)

vectorizer = EpochsVectorizer(jumping_mean_ivals=ivals, sfreq = epochs.info['sfreq'], t_ref = epochs.times[0])
X = vectorizer.transform(epochs)

nch = 7
ntim = 10
N = X.shape[0]

mat = list()
for n in range(N):
    tmp = np.reshape(X[n], (nch*ntim, 1))
    mat.append(np.cov(tmp))
mat = np.array(mat)

mat = mat.transpose((1,2,0))
print(mat.shape)

mat = mat[:,:,0]

np.save('cov.npy',mat,allow_pickle=True)
"""
#nch = 7
#ntim = 10
#mat = np.load('cov.npy')
nch = 2
ntim = 4

mat = np.arange(1,65)
mat = np.reshape(mat, (8,8), 'F')


std = SpatioTemporalMatrix(mat, nch, ntim, True)
std.force_toeplitz_offdiagonals()