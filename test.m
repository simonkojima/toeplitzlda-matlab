
clearvars
clc

%run("/home/simon/git/matlibs/setup.m")

%mat = readNPY('cov.npy');

mat = 1:64;
mat = reshape(mat, [8,8]);

nch = 2;
ntim = 4;

stm = SpatioTemporalMatrix(mat,nch,ntim, true);
stm = stm.force_toeplitz_offdiagonals();
stm = stm.taper_offdiagonals(@linear_taper);
%stm = stm.taper_offdiagonals();
stm.mat
a = stm.mat
save('param','a')
%size(stm.mat)