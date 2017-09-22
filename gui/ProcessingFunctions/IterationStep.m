function IterationStep(this)

image_Lin = this.current_frame .* uint8(this.Lin); %masking
image_Lout = this.current_frame .* uint8(this.Lout); %masking
image_exterior = this.current_frame .* uint8(this.phi == int8(PhiTypes.Exterior_pixel)); %masking
image_interior = this.current_frame .* uint8(this.phi == int8(PhiTypes.Interior_pixel)); %masking

% F = image_Lin;
image(image_Lin, 'Parent', this.handles.axes_image);
image(image_Lout, 'Parent', this.handles.axes_image);
image(image_exterior, 'Parent', this.handles.axes_image);
image(image_interior, 'Parent', this.handles.axes_image);

mu_interior = mean(mean(nonzeros(image_interior)));
mu_exterior = mean(mean(nonzeros(image_exterior)));

this.current_frame_copy =this.current_frame_copy*0 + mu_interior;
image(this.current_frame_copy, 'Parent', this.handles.axes_image);

this.current_frame_copy = this.current_frame_copy*0 + mu_exterior;
image(this.current_frame_copy, 'Parent', this.handles.axes_image);

% Fd = arrayfun(@(image_Lin) this.distribution(image_Lin, mu, size(this.current_frame, 3)), image_Lin);
% F = this.distribution(x, mu, size(this.current_frame, 3));
% 
% p_in = zeros(size(this.current_frame));
% p_out = zeros(size(this.current_frame));

for it1 = 1:size(image_Lin, 1)
    for it2 = 1:size(image_Lin, 2)
        if (this.Lin(it1, it2, 1) == 1)
            p_in = this.distribution.pdfeval(mu_interior, double(image_Lin(it1, it2, :)), size(this.current_frame, 3));
            p_out = this.distribution.pdfeval(mu_exterior, double(image_Lin(it1, it2, :)), size(this.current_frame, 3));
            this.Fd(it1, it2) = log(p_in / p_out);
        end
    end
end

end