function result = StoppingCondition(this, frame)

for itt = 1:size(frame, 3)
    image_Lin(:, :, itt) = frame(:, :, itt) .* uint8(this.Lin); %masking
    image_Lout(:, :, itt) = frame(:, :, itt) .* uint8(this.Lout); %masking
    % image_exterior(:, :, itt) = frame(:, :, itt) .* uint8(this.phi == int8(PhiTypes.Exterior_pixel)); %masking
    image_interior(:, :, itt) = frame(:, :, itt) .* uint8(this.phi == int8(PhiTypes.Interior_pixel)); %masking
    
    % F = image_Lin;
    % image(image_Lin, 'Parent', this.handles.axes_image);
    % image(image_Lout, 'Parent', this.handles.axes_image);
    % image(image_exterior, 'Parent', this.handles.axes_image);
    % image(image_interior, 'Parent', this.handles.axes_image);
    
    mu_interior(itt) = mean(nonzeros(image_interior(:, :, itt)));
    mu_exterior(itt) = mean(mean(nonzeros(image_Lout(:, :, itt))));
end
mu_interior = mu_interior';
mu_exterior = mu_exterior';
% Fd = arrayfun(@(image_Lin) this.distribution(image_Lin, mu, size(frame, 3)), image_Lin);
% F = this.distribution(x, mu, size(frame, 3));
%
% p_in = zeros(size(frame));
% p_out = zeros(size(frame));

ones_of_Lout = find(this.Lout)';
ones_of_Lin = find(this.Lin)';

%Step 2.1

for iter = ones_of_Lin
    [it1, it2] = ind2sub(size(this.Lin), iter);
    p_in = this.distribution.pdfeval(mu_interior, double(squeeze(image_Lin(it1, it2, :))), size(frame, 3));
    %     p_out = this.distribution.pdfeval(mu_exterior, double(squeeze(image_Lin(it1, it2, :))), size(frame, 3));
    if abs(p_in - 1) < this.threshold
        this.Fd(it1, it2) = 1;
    else
        this.Fd(it1, it2) = -1;
    end
end

for iter = ones_of_Lout
    [it1, it2] = ind2sub(size(this.Lout), iter);
    %     p_in = this.distribution.pdfeval(mu_interior, double(squeeze(image_Lout(it1, it2, :))), size(frame, 3));
    p_out = this.distribution.pdfeval(mu_interior, double(squeeze(image_Lout(it1, it2, :))), size(frame, 3));
    %     this.Fd(it1, it2) = log(p_in/p_out);
    if abs(p_out - 1) < this.threshold
        this.Fd(it1, it2) = 1;
    else
        this.Fd(it1, it2) = -1;
    end
end

result = true;

ones_of_Lout = find(this.Lout)';
for iter = ones_of_Lout
    [it1, it2] = ind2sub(size(this.Lout), iter);
    if this.Fd(it1, it2) >= 0
        result = false;
        return;
    end
    
end

ones_of_Lin = find(this.Lin)';
for iter = ones_of_Lin
    [it1, it2] = ind2sub(size(this.Lin), iter);
    if this.Fd(it1, it2) <= 0
        result = false;
        return;
    end
end


end