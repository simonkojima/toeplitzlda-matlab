function d = diagonal_4d(a, offset)
%
% compute diagonal elements of 4d matrix.
% 
% designed for working as same as numpy.diagonal()
% author : simon kojima
% 
% v1 : 29 Sep 2022

if nargin < 2
    offset = 0;
end

dim = size(a);

min_dim = min(dim(1:2));
if offset == 0
    dim_d = min_dim;
elseif offset < 0
    dim_d = dim(1) - abs(offset);
elseif offset > 0
    dim_d = dim(2) - abs(offset);
end

if dim_d > min_dim
   dim_d = min_dim; 
end

for m = 1:dim_d
   e{m}  = [];
end

for third = 1:dim(3)
   for fourth = 1:dim(4) 
       a_2d = a(:,:,third,fourth);
       for m = 1:dim_d
           if offset <= 0
               e{m} = [e{m} a_2d(m+abs(offset),m)];
           elseif offset > 0
               e{m} = [e{m} a_2d(m,m+abs(offset))];
           end
       end
   end
end

d = [];
for m = 1:dim_d
   d(:,:,m) = reshape(e{m},[dim(4),dim(3)])';
end

end


