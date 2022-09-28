function [X, cl_mean] = subtract_classwise_means(xTr, y, ext_mean)

if nargin < 3
    ext_mean = [];
end

classes = unique(y);
n_classes = length(classes);
n_features = size(xTr,1);

X = zeros(n_features, 0);
cl_mean = zeros(n_features, n_classes);

for ci = 1:n_classes
    cur_class = classes(ci);
    class_idxs = find(y==cur_class);
    cl_mean(:, ci) = mean(xTr(:, class_idxs), 2);
    if isempty(ext_mean)
        tmp = reshape(cl_mean(:, ci),[],1)*ones(1, length(class_idxs));
        tmp = xTr(:, class_idxs) - tmp;
        X = cat(2, X, tmp);
    else
        error("ext_mean is not implemented yet.")
    end
end

end