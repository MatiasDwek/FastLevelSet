function GaussianFilterStep(this)
sigma = 1;
Ng = 3;
gaussian_filter = fspecial('gaussian', Ng, sigma);

%Step 3.1
ones_of_Lout = find(this.Lout)';
for iter = ones_of_Lout
    [it1, it2] = ind2sub(size(this.Lout), iter);
    step_center = floor(Ng/2);
    % Problema de bordes!
    sub_phi = this.phi(it1 - step_center:it1 + step_center, it2 - step_center:it2 + step_center);
    filtering_result = conv2(double(sub_phi), gaussian_filter);
    filtering_result_center = filtering_result(Ng, Ng);
    if (filtering_result_center < 0)
        SwitchIn(this, it1, it2);
    end
end

%Step 3.2
ones_of_Lin = find(this.Lin)';
for iter = ones_of_Lin
    [it1, it2] = ind2sub(size(this.Lin), iter);
    if (this.phi(min(it1+1, this.frame_height), it2) < 0)
        if (this.phi(it1, min(it2+1, this.frame_width)) < 0)
            if (this.phi(max(it1-1, 1), it2) < 0)
                if (this.phi(it1, max(it2-1, 1)) < 0)
                    this.Lin(it1, it2) = 0;
                    this.phi(it1, it2) = int8(PhiTypes.Interior_pixel);
                end
            end
        end
    end
end

%Step 3.3
ones_of_Lin = find(this.Lin)';
for iter = ones_of_Lin
    [it1, it2] = ind2sub(size(this.Lin), iter);
    step_center = floor(Ng/2);
    % Problema de bordes!
    sub_phi = this.phi(it1 - step_center:it1 + step_center, it2 - step_center:it2 + step_center);
    filtering_result = conv2(double(sub_phi), gaussian_filter);
    filtering_result_center = filtering_result(Ng, Ng);
    if (filtering_result_center > 0)
        SwitchOut(this, it1, it2);
    end
end

%Step 3.4
ones_of_Lout = find(this.Lout)';
for iter = ones_of_Lout
    [it1, it2] = ind2sub(size(this.Lout), iter);
    if (this.phi(min(it1+1, this.frame_height), it2) > 0)
        if (this.phi(it1, min(it2+1, this.frame_width)) > 0)
            if (this.phi(max(it1-1, 1), it2) > 0)
                if (this.phi(it1, max(it2-1, 1)) > 0)
                    this.Lout(it1, it2) = 0;
                    this.phi(it1, it2) = int8(PhiTypes.Exterior_pixel);
                end
            end
        end
    end
end

end