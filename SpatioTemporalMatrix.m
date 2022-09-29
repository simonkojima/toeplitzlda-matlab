classdef SpatioTemporalMatrix < BlockMatrix
    
    properties
        is_inverted
        montage
        sfreq
    end
    
    methods
        function obj = SpatioTemporalMatrix(matrix, n_chans, n_times, channel_prime, montage, sfreq)
            if channel_prime == true
                block_label = ["channel" "time"];
            else
                block_label = ["time" "channel"];
            end
            obj@BlockMatrix(matrix, [n_chans n_times], block_label);
            
            obj.is_inverted = false;
            if nargin > 4
                obj.montage = montage;
            end
            
            if nargin > 5
                obj.sfreq = sfreq;
            end
        end
        
        function obj = force_toeplitz_offdiagonals(obj, average_blocks, raise_spatial, normalize_within)
            if nargin < 2
                average_blocks = true;
            end
            if nargin < 3
                raise_spatial = true;
            end
            if nargin < 4
                normalize_within = false;
            end
            
            dim = obj.block_dim(2);
            for di = (-dim+1):(dim-1)
            %for di = -2:-2
                %di = -4
                %di
                [obj,d] = obj.get_block_diagonal(di);      
                
                if average_blocks == true
                    new_d = mean(d, 3);
                else
                    new_d = sum(d, 3);
                end
                %ok
                obj = obj.set_block_diagnal_blockmat(new_d, di);
                
                %error("abc")
            end
            obj = obj.to_2dblockmat();
        end
        
        function obj = taper_offdiagonals(obj, taper_f)
            if nargin < 2
               taper_f = @linear_taper;
            end
            dim = obj.block_dim(2);
            for di = (-dim+1):(dim-1)
            %for di = 1:1
                
                [obj,d] = obj.get_block_diagonal(di);
                new_d = d*linear_taper(di, dim);
                obj = obj.set_block_diagnal_blockmat(new_d, di);
            end
            obj = obj.to_2dblockmat();
        end
    end
end