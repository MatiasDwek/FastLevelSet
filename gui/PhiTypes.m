classdef PhiTypes < int8
   enumeration
      Exterior_pixel (3)
      Lout_pixel (1)
      Lin_pixel (-1)
      Interior_pixel (-3)
   end
end

%use like this: int8(PhiTypes.Interior_pixel)