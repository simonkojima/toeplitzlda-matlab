classdef StandardScaler
    
    properties
        u
        s
    end
    
    methods
        
        function obj = StandardScaler()
            
        end
        
        function [obj,x] = fit_transform(obj, x, axis, std_w)
            if nargin < 3
               axis = 1;
            end
            if nargin < 4
               std_w = 0;
            end
            obj.u = mean(x,axis);
            obj.s = std(x,std_w,axis);
            x = (x-obj.u)./obj.s;
        end
        
        function x = transform_invert(obj, x)
            x = (x.*obj.s)+obj.u;
        end

    end
end