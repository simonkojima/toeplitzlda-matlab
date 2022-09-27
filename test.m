
clearvars
clc

%run("/home/simon/git/matlibs/setup.m")

%mat = readNPY('cov.npy');

mat = 1:64;
mat = reshape(mat, [8,8])

nch = 2;
ntim = 4;

stm = SpatioTemporalMatrix(mat,nch,ntim,true);
stm = stm.force_toeplitz_offdiagonals();
stm.mat
%size(stm.mat)