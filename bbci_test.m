%% setup

home_dir = get_home_dir();
data_dir = fullfile(home_dir, 'Documents', 'eeg');
git_dir = fullfile(home_dir, 'git');
bbci_dir = fullfile(git_dir, 'bbci_public');
addpath(bbci_dir);
startup_bbci_toolbox('DataDir', data_dir);

%% load data
file = fullfile(BTB.DataDir, 'auditory_aphasia_stereo', 'VPexp007_22_06_08','standard_Oddball');
[cnt, mrk] = file_readBV(file);

% Exclude possible EOG ro EMG channels
cnt= proc_selectChannels(cnt, 'not', 'vEOG');
n_channels = length(cnt.clab);

% Segmentation
epo= proc_segmentation(cnt, mrk, [-100 800]);

% Select discriminative time intervals
epo_r= proc_rSquareSigned(epo);
ival_cfy= procutil_selectTimeIntervals(epo_r);

%% classify

% Feature extraction  (spatio-temporal features)
fv= proc_baseline(epo, [-100 0]);
fv= proc_jumpingMeans(fv, ival_cfy);

%loss = crossvalidation(fv, @train_RLDAshrink, 'SampleFcn', {@sample_KFold, 10, 'Stratified',1});
loss = crossvalidation(fv, {@train_toeplitz, 'n_channels', n_channels}, 'SampleFcn', {@sample_KFold, 10, 'Stratified',1});
acc = 100-loss*100;
fprintf('acc : %.3f\n', acc)