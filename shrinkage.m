function [Cstar, gamma] = shrinkage(X, gamma, T, S, standardize)

if nargin < 2
    gamma = [];
end
if nargin < 3
    T = [] ;
end
if nargin < 4
    S = [];
end
if nargin < 5
    standardize = true;
end

[p,n] = size(X);

if standardize
    sc = StandardScaler();
    [sc,X] = sc.fit_transform(X, 2, 1);
end

Xn = X - repmat(mean(X,2), 1, n);

if isempty(S)
    S = Xn*Xn';
end

Xn2 = power(Xn, 2);

nu = mean(diag(S));


if isempty(T)
    T = nu * eye(p,p);
end


V = 1.0 / (n - 1) * (Xn2*Xn2' - power(S,2) / n);

if isempty(gamma)
    gamma = n * sum(V, 'all') / sum(power(S-T,2), 'all');
end
if gamma > 1
    fprintf("WARNING : forcing gamma to 1\n")
    gamma = 1;
elseif gamma < 0
    fprintf("WARNING : forcing gamma to 0\n")
    gamma = 0;
end

Cstar = (gamma * T + (1 - gamma) * S) / (n - 1);

if standardize
    Cstar = sc.s'.*Cstar.*sc.s;
end

end