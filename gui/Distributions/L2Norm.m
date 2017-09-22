classdef L2Norm < DistributionFunction
    methods
        function p = pdfeval(~, mu, v, k)
            p = 1 - norm(squeeze(mu-v), 2)/(256*k);
        end
    end
    
    properties (Constant)
        type = DistributionFunctionTypes.L2_norm_t;
    end
end