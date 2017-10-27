function InitVariables(this)
this.init = true;

this.Fd = zeros(size(this.current_frame, 1), size(this.current_frame, 2));

this.phi = int8(ones(size(this.current_frame, 1), size(this.current_frame, 2)));

start_pos = round(this.click_position_start);
end_pos = round(this.click_position_end);

%exterior pixels
this.phi = this.phi*int8(PhiTypes.Exterior_pixel);

%interior pixels
this.phi(start_pos(2)+1:end_pos(2)-1, start_pos(1)+1:end_pos(1)-1) = int8(PhiTypes.Interior_pixel);

%Lin pixels
this.phi(start_pos(2), start_pos(1):end_pos(1)) = int8(PhiTypes.Lin_pixel); %|o
this.phi(end_pos(2), start_pos(1):end_pos(1)) = int8(PhiTypes.Lin_pixel); %o|
this.phi(start_pos(2):end_pos(2), start_pos(1)) = int8(PhiTypes.Lin_pixel); %ó
this.phi(start_pos(2):end_pos(2), end_pos(1)) = int8(PhiTypes.Lin_pixel); %_o

%Lout pixels
this.phi(start_pos(2)-1, start_pos(1):end_pos(1)) = int8(PhiTypes.Lout_pixel); %|o
this.phi(end_pos(2)+1, start_pos(1):end_pos(1)) = int8(PhiTypes.Lout_pixel); %o|
this.phi(start_pos(2):end_pos(2), start_pos(1)-1) = int8(PhiTypes.Lout_pixel); %ó
this.phi(start_pos(2):end_pos(2), end_pos(1)+1) = int8(PhiTypes.Lout_pixel); %_o

%Lin structure
this.Lin = zeros(size(this.current_frame, 1), size(this.current_frame, 2));
this.Lin(start_pos(2), start_pos(1):end_pos(1)) = 1; %|o
this.Lin(end_pos(2), start_pos(1):end_pos(1)) = 1; %o|
this.Lin(start_pos(2):end_pos(2), start_pos(1)) = 1; %ó
this.Lin(start_pos(2):end_pos(2), end_pos(1)) = 1; %_o

%Lout structure
this.Lout = zeros(size(this.current_frame, 1), size(this.current_frame, 2));
this.Lout(start_pos(2)-1, start_pos(1):end_pos(1)) = 1; %|o
this.Lout(end_pos(2)+1, start_pos(1):end_pos(1)) = 1; %o|
this.Lout(start_pos(2):end_pos(2), start_pos(1)-1) = 1; %ó
this.Lout(start_pos(2):end_pos(2), end_pos(1)+1) = 1; %_o

end