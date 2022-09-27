classdef BlockMatrix < BlockBased
   
    properties
        mat
        props
   end
   
   methods
      function obj = BlockMatrix(matrix, block_dim, block_label)
          if nargin == 2
              block_label = [];
          end
          obj@BlockBased(block_dim, block_label);
          obj.mat = matrix;
          obj.props = [];
      end      
      
      function obj = to_4dblockmat(obj)
         if isvector(obj.mat)
             return
         elseif ndims(obj.mat) ~= 2
             return
         end
         axes = obj.block_dims(1,2,1,2);
         stacked_mat = reshape(obj.mat,axes);
         stacked_mat = permute(stacked_mat, [1 3 2 4]);
         %stacked_mat = multi_dimension_transpose(stacked_mat);
         stacked_mat = permute(stacked_mat, [4,3,2,1]);
         obj.mat = stacked_mat;
      end
      
      function obj = to_2dblockmat(obj)
         if isvector(obj.mat)
             return
         elseif ndims(obj.mat) ~= 4
             return
         end
         shape = obj.block_dim(1)*obj.block_dim(2);
         mat = obj.mat;
         mat = permute(obj.mat, [4,3,2,1]);
         %mat = multi_dimension_transpose(mat);
         mat = permute(mat, [3,1,2,4]);

         mat_2d = [];
         for m = 1:size(mat,3)
            for n = 1:size(mat,4) 
               mat_2d(:,:,m,n) = mat(:,:,m,n)';
            end
         end
         mat_2d = reshape(mat_2d, [shape, shape]);
         
         obj.mat = mat_2d;
      end
      
      function [obj, d, idx] = get_block_diagonal(obj, diagonal_offset)
         obj = obj.to_4dblockmat();
         [d,idx] = diagND(obj.mat,[],[], diagonal_offset);
      end
      
      function obj = set_block_diagnal_blockmat(obj, blockmat, diagonal_offset)
        repeats = obj.block_dim(2) - abs(diagonal_offset);
        blockmat = reshape(blockmat, 1, []);

        if size(blockmat,3) == 1
            blockmat = repmat(blockmat, [repeats 1]);
        end

        [obj,d,idx] = obj.get_block_diagonal(diagonal_offset);
        obj.mat(idx) = blockmat;
      end
   end
end