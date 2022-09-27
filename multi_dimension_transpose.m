function matrix2=multi_dimension_transpose(matrix)
% multi_dimension_transpose(matrix)
%
% Transposes each matrixplane of a multi-dimensional matrix
% while maintaining the original matrix structure
% I originialy wrote a script to do this using a bunch of simple functions
% I recieved a review pointing out this simpler code.
% I've replaced his with mine since it seems to be faster.
% Thanks to Jos x.


if isfinite(matrix);
    matrix2=permute(matrix,[2 1 3:ndims(matrix)]);
end;