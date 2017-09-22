classdef L1Norm < DistributionFunction
    methods
        function p = pdfeval(~, mu, v, k)
            p = 1 - norm(squeeze(mu-v), 1)/(256*k);
        end
    end
    
    properties (Constant)
        type = DistributionFunctionTypes.L1_norm_t;
    end
end