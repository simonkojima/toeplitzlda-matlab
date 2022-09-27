function [dND,idx] = diagND(ND,rowDim,colDim, offset)
%% Purpose:
%
%  Given an ND matrix containing two known dimensions (e.g. row and column
%  of a 2D matrix), compute the diagonal accross any two dimensions of an
%  N-Dimensional matrix.
%
%  Return this diagonal in the same form as the ND matrix, but with the row
%  dimension set to 1 (i.e. singularized).
%
%% Inputs:
%  N-D Matrix               [M x N x O x .... ]             Arbitrary
%                                                           Dimensonal
%                                                           Matrix
%                                                           containing at
%                                                           least two
%                                                           dimensions in
%                                                           which to take
%                                                           the diagonal.
%
% rowDim                    int                             Dimension
%                                                           specifier of
%                                                           the row
%                                                           dimension
%
% colDim                    int                             Dimension
%                                                           specifier of
%                                                           the column
%                                                           dimension
%
%% Outputs:
%  dND                      [1 x N x O x ... ]              Diagonal
%                                                           Components of
%                                                           the
%                                                           multi-dimensional
%                                                           array
%
%
%% Revision History:
%  Darin C. Koblick(c) 01-16-2015

if nargin == 3
   offset = -3;
end
%% Permute the ND matrix such that row x column are upfront:
          oDimVals = size(ND);
       origDimSize = 1:length(size(ND));
        permuteSeq = origDimSize;
        %Swap One Element at a time:
        permuteSeq([1,rowDim]) = permuteSeq([rowDim,1]);
        permuteSeq([2,colDim]) = permuteSeq([colDim,2]);
                ND = permute(ND,permuteSeq);
          nDimVals = size(ND);
          nDimVals(1) = 1;
%% Next, Reshape the matrix such that it is only 3D:
 ND = reshape(ND,[size(ND,1),size(ND,2),numel(ND)/(size(ND,1)*size(ND,2))]);
%% Now, with a single indexing sequence, extract all diagonal elements:
c = zeros(size(ND,1),1);
r = zeros(size(ND,2),1);
if offset == 0
    r(1) = 1;
    c(1) = 1;
elseif offset > 0
    r(1+offset) = 1;
else
    c(1+abs(offset)) = 1;
end
I = toeplitz(c,r); % substitution of eye(size(ND,1),size(ND,2))

idx = find(repmat(I,[1 1 size(ND,3)]));

dND = reshape(sort(ND(idx)), oDimVals(3), oDimVals(3), oDimVals(1)-abs(offset));
dND = permute(dND, [2,1,3]);

%abs(offset)

%dND = reshape(ND(idx),[1 size(ND,2) size(ND,3)]);
%dND = reshape(ND(idx),[oDimVals(3) oDimVals(3) oDimVals(1)-abs(offset)]);


%% Reshape the dND matrix such that it is back to it's ND counterpart:

%dND = reshape(dND,[oDimVals(3) oDimVals(3) 1]);
%dND = reshape(dND,nDimVals); % original
%% Put the Dimension Sequence Back to their original locations: 

%permuteSeq
%dND = ipermute(dND,permuteSeq);
end