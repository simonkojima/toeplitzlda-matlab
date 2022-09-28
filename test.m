
clearvars
clc

%run("/home/simon/git/matlibs/setup.m")

%mat = readNPY('cov.npy');

mat = 1:100;
mat = reshape(mat, [10,10]);

nch = 2;
ntim = 5;

%stm = SpatioTemporalMatrix(mat,nch,ntim,true);
%stm = stm.force_toeplitz_offdiagonals();
%stm = stm.taper_offdiagonals(@linear_taper);
%stm = stm.taper_offdiagonals();
%stm.mat
%size(stm.mat)