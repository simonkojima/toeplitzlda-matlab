clearvars
clc

load('oddball.mat');

clf = ToeplitzLDA(64,true, false);
clf = clf.fit(X, Y);

clf.w
clf.b

a = clf.w
save("param", 'a')

%xTr = transpose(X);
%[X, cl_mean] = subtract_classwise_means(xTr,Y);

%s = standardize();
%[obj,x] = s.fit_transform(X,2);

%C_cov, C_gamma = shrinkage(X,standardize=self.standardize_shrink,gamma=self.fixed_gamma,)

%shrinkage(X)