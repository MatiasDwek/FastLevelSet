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

mu = mean(mean(image_interior));
F = arrayfun(@(image_Lin) this.distribution(image_Lin, mu, size(this.current_frame, 3)), image_Lin);
% F = this.distribution(x, mu, size(this.current_frame, 3));


end