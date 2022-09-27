classdef BlockBased
   
    properties
        block_dim
        block_label
   end
   
   methods
      function obj = BlockBased(block_dim, block_label)
          obj.block_dim = block_dim;
          if nargin > 1
              obj.block_label = block_label;            
          end
      end
      
      function dims = block_dims(obj, varargin)
        %Helper function, useful for, e.g., reshaping of matrices.
        %
        %Instead of:
        %    mat = np.reshape(mat, (self.block_dim[0], self.block_dim[1], self.block_dim[0], self.block_dim[1]))
        %You can use:
        %    mat = np.reshape(mat, self.block_dims(0, 1, 0, 1))
        dims = [];
        for l = 1:length(varargin)
           dims = [dims obj.block_dim(varargin{l})];
        end
      end
   end
end