classdef Gaussian < DistributionFunction
    methods
        function p = pdfeval(~, mu, v, k, sigma)
%             p = 1/(sqrt(2*pi)*sigma) * exp(-(u - v;
        end
    end
    
    properties (Constant)
        type = DistributionFunctionTypes.Gaussian_t;
    end
end