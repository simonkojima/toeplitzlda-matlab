classdef ToeplitzLDA
    
    properties
        n_channels
        n_times
        data_is_channel_prime
        classes
        pool_cov
        enforce_toeplitz
        tapering
        stored_cl_mean
        stored_stm
        unit_w
        %coef
        %intercept
        w
        b
    end
    
    methods
        
        function obj = ToeplitzLDA(n_channels, pool_cov, unit_w)
            obj.n_times = "infer";
            obj.data_is_channel_prime = true;
            obj.enforce_toeplitz = true;
            obj.tapering = 'linear';
            
            obj.n_channels = n_channels;
            if nargin < 2
                obj.pool_cov = true;
            else
                obj.pool_cov = pool_cov;
            end
            if nargin < 3
                obj.unit_w = false;
            end
        end
        
        function obj = fit(obj, X_train, y)
            %
            % X_train : number_of_samples x number_of_features
            % y : number_of_samples (if y(i) == a, i belongs to class a.)
            %
            
            obj.classes = unique(y);
            xTr = transpose(X_train);
            % in python, if priors is None:
            y_t = [];
            for m = 1:length(y)
                y_t = [y_t; find(obj.classes == y(m))];
            end
            priors = histcounts(y_t) / length(y);
            
            [X, cl_mean] = subtract_classwise_means(xTr, y);
            % OK

            if obj.pool_cov
                [C_cov, C_gamma] = shrinkage(X);
            else
                error("pool_cov = False is not implemented yet")
            end
            
            % OK
            
            dim = size(C_cov,1);
            nt = calc_n_times(dim, obj.n_channels, obj.n_times);
            stm = SpatioTemporalMatrix(C_cov, obj.n_channels, nt, obj.data_is_channel_prime);
            
            if obj.enforce_toeplitz
                stm = stm.force_toeplitz_offdiagonals();
            end
            
            if ~isempty(obj.tapering)
                stm = stm.taper_offdiagonals();
            end           
            
            % OK
            
            obj.stored_cl_mean = cl_mean;
            obj.stored_stm = stm;
            C_cov = stm.mat;           
            
            prior_offset = log(priors);

            w = linsolve(C_cov, cl_mean);
            if obj.unit_w
                w = w / norm(w);
            end
            
            b = -0.5 * sum(cl_mean.*w,1) + prior_offset;
            
            obj.w = w';
            obj.b = b;
        end
    end
end